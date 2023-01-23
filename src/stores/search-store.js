import { defineStore } from "pinia";

export const useSearchStore = defineStore("searchstore", {
  state: () => ({
    search: "",
    movies: [],
    hasMore: true,
    page: 1,
  }),
  getters: {
    searchText: (state) => state.search,
    movies: (state) => state.movies,
    hasMore: (state) => state.hasMore,
    page: (state) => state.page,
  },
  actions: {
    resetMovies() {
      this.movies = [];
    },
    setMovies(result) {
      this.movies = result;
    },
    setSearch(searchText) {
      this.search = searchText;
    },
    setHasMore(hasMoreResults) {
      this.hasMore = hasMoreResults;
    },
    resetPageCount() {
      this.page = 1;
    },
    incrementPageCount() {
      this.page++;
    },
  },
});
