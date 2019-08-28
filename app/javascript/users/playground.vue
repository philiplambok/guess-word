<template>
  <div>
    {{ name }}
    {{ point }} points
    <div id="random-word">{{ randomWord }}</div>
  </div>
</template>

<script>
export default {
  props: ["name", "point"],
  data() {
    return {
      randomWordId: null,
      randomWord: ""
    };
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
