<template>
  <q-input
    dark
    dense
    v-model="search"
    input-class="text-left"
    class="q-ml-md absolute-center"
    placeholder="Bsp.: Terminator"
    @keyup.enter="doSearch"
  >
    <template v-slot:append>
      <q-icon v-if="search === ''" name="search" />
      <q-icon v-else name="clear" class="cursor-pointer" @click="search = ''" />
    </template>
  </q-input>
</template>

<script>
import { ref } from "vue";

export default {
  name: "MovieSearch",
  setup() {
    return {
      search: ref(""),
    };
  },
  methods: {
    doSearch() {
      const search = this.search;
      this.$router.push({ name: "results", query: { search: search } });
    },
  },
};
</script>
