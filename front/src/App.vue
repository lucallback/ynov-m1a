<script setup lang="ts">
import { ref } from "vue";
import axios from "axios";

const file = ref<File | null>(null);
// const listFiles = reactive<string[]>([]);
const listFiles = ref<string[]>([]);

const uploadFile = (e: Event) => {
  const target = e.target as HTMLInputElement;
  const files = target.files;
  if (files) {
    file.value = files[0];
  }
};

const submitFile = async () => {
  if (file.value) {
    const formData = new FormData();
    formData.append("file", file.value);
    try {
      const res = await axios.post("http://localhost:3000/upload", formData);
      console.log(res.data);
      if(res.data){
        fetchFile();
      }
    } catch (error) {
      console.error(error);
    }
  }
};

const fetchFile = async () => {
  try {
    const res = await axios.get("http://localhost:3000/files");
    console.log(res.data);
    listFiles.value = res.data;
  } catch (error) {
    console.error(error);
  }
};

fetchFile();

</script>

<template>
  <div>
    <input type="file" @change="uploadFile" />
    <button @click="submitFile">Submit
    </button>
  </div>
  <div v-for="f in listFiles" :key="f">
    {{ f }}
  </div>
</template>

<style scoped>
.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}
.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}
.logo.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
}
</style>
