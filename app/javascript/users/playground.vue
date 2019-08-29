<template>
  <div>
    <div class="d-flex justify-content-between">
      <div>
        <span class="font-weight-bold">{{ name }}</span>
        <div>{{ point }} points</div>
      </div>
      <div>
        <a href="/rankings" class="px-2">Ranking</a>
        <a href="/abouts">About</a>
      </div>
    </div>

    <div>
      <div id="random-word" class="display-3 my-4">{{ randomWord }}</div>

      <div v-show="message != ''">
        <div
          class="alert alert-dismissible fade show"
          role="alert"
          :class="{'alert-success': success, 'alert-danger': !success}"
        >
          {{ message }}
          <button @click="closeMessage()" class="close" type="button">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
      </div>

      <input
        type="text"
        id="guess_word"
        v-model="guessWord"
        placeholder="Masukan tebakan katanya"
        class="form-control my-4"
        autocomplete="off"
      >
      <div class="d-flex justify-content-between">
        <button @click.prevent="submit()" class="btn btn-primary px-4">Submit</button>
        <button class="btn btn-secondary px-4" @click="reset()">Reset</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["userid", "name", "initialpoint"],
  data() {
    return {
      point: 0,
      success: null,
      message: "",
      randomWordId: null,
      randomWord: "",
      guessWord: ""
    };
  },
  methods: {
    closeMessage() {
      this.message = "";
    },
    reset() {
      this.point = 0;
      // Update the point to database
      let csrf_token = this.find_csrf_token();
      let request = new Request(`/api/v1/users/${this.userid}`, {
        method: "PUT",
        headers: {
          "Content-type": "application/json",
          "X-CSRF-Token": csrf_token
        },
        body: JSON.stringify({ user: { point: this.point } })
      });
      fetch(request)
        .then(response => response.json())
        .then(data => {
          this.guessWord = "";
          this.message = "";
        });
    },
    submit() {
      fetch(`/api/v1/words/${this.randomWordId}`)
        .then(response => response.json())
        .then(data => {
          let correctAnswer = data.text;
          if (correctAnswer === this.guessWord) {
            this.success = true;
            this.point += 1;
            // Update the point to database
            let csrf_token = this.find_csrf_token();
            let request = new Request(`/api/v1/users/${this.userid}`, {
              method: "PUT",
              headers: {
                "Content-type": "application/json",
                "X-CSRF-Token": csrf_token
              },
              body: JSON.stringify({ user: { point: this.point } })
            });
            fetch(request)
              .then(response => response.json())
              .then(data => {
                this.message = `BENAR, point anda menjadi ${this.point}`;
                this.guessWord = "";
              });
          } else {
            this.success = false;
            this.message = `SALAH! Silahkan coba lagi`;
            this.guessWord = "";
          }
        });
    },
    find_csrf_token() {
      let csrf_token_dom = document.querySelector('meta[name="csrf-token"]');
      let csrf_token = "";
      if (csrf_token_dom) {
        csrf_token = csrf_token_dom.content;
      }
      return csrf_token;
    }
  },
  mounted() {
    this.point = parseInt(this.initialpoint);
    fetch("/api/v1/random_words")
      .then(response => response.json())
      .then(data => {
        this.randomWordId = data.id;
        this.randomWord = data.random_word;
      });
  }
};
</script>
