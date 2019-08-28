<template>
  <div>
    {{ name }}
    {{ point }} points
    <div id="random-word">{{ randomWord }}</div>
    <div if="success">{{ message }}</div>
    <input type="text" id="guess_word" v-model="guessWord">
    <button @click.prevent="submit()">Submit</button>
  </div>
</template>

<script>
export default {
  props: ["name", "point"],
  data() {
    return {
      success: false,
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
            this.message = "BENAR point anda menjadi 1";
          }
        });
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
