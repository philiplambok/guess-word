<template>
  <div>
    {{ name }}
    {{ point }} points
    <div id="random-word">{{ randomWord }}</div>
    <div v-if="success === true">{{ message }}</div>
    <div v-if="success === false">{{ message }}</div>
    <input type="text" id="guess_word" v-model="guessWord">
    <button @click.prevent="submit()">Submit</button>
  </div>
</template>

<script>
export default {
  props: ["name", "point"],
  data() {
    return {
      success: null,
      message: "",
      randomWordId: null,
      randomWord: "",
      guessWord: ""
    };
  },
  methods: {
    submit() {
      fetch(`/api/v1/words/${this.randomWordId}`)
        .then(response => response.json())
        .then(data => {
          let correctAnswer = data.text;
          if (correctAnswer === this.guessWord) {
            this.success = true;
            this.increaseThePoint();
            this.message = `BENAR, point anda menjadi ${this.point}`;
            this.guessWord = "";
          } else {
            this.success = false;
            this.message = `SALAH! Silahkan coba lagi`;
            this.guessWord = "";
          }
        });
    },
    increaseThePoint() {
      this.point = parseInt(this.point);
      this.point += 1;
    }
  },
  mounted() {
    fetch("/api/v1/random_words")
      .then(response => response.json())
      .then(data => {
        this.randomWordId = data.id;
        this.randomWord = data.random_word;
      });
  }
};
</script>
