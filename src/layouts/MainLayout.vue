<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <img
          src="MovieFinder.png"
          alt="MovieFinder Logo"
          style="height: 100px; width: 100px"
        />
        <q-toolbar-title class="primary"> MovieFinder </q-toolbar-title>
        <movie-search />
      </q-toolbar>
    </q-header>

    <q-page-container>
      <router-view :key="$route.fullPath" />
    </q-page-container>
  </q-layout>
</template>

<script>
import { defineComponent, ref } from "vue";
import MovieSearch from "../components/MovieSearch.vue";

export default defineComponent({
  name: "MainLayout",

  components: { MovieSearch },
  methods: {},
});
</script>
