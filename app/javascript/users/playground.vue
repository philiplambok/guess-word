<template>
  <div>
    <div class="d-flex justify-content-between">
      <div>
        <span class="font-weight-bold">{{ name }}</span>
        <div>{{ point }} points</div>
      </div>
      <div>
        <a href="#">About</a>
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
      >
      <button @click.prevent="submit()" class="btn btn-primary px-4">Submit</button>
    </div>
  </div>
</template>

<script>
export default {
  props: ["name", "initialpoint"],
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
    submit() {
      fetch(`/api/v1/words/${this.randomWordId}`)
        .then(response => response.json())
        .then(data => {
          let correctAnswer = data.text;
          if (correctAnswer === this.guessWord) {
            this.success = true;
            this.point += 1;
            this.message = `BENAR, point anda menjadi ${this.point}`;
            this.guessWord = "";
          } else {
            this.success = false;
            this.message = `SALAH! Silahkan coba lagi`;
            this.guessWord = "";
          }
        });
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
