<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-toolbar-title> Moviefinder App </q-toolbar-title>
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
