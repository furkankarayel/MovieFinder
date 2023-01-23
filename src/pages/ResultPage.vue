<template>
  <q-page :key="componentKey">
    <div
      class="q-pa-md"
      style="
        max-width: 900px;
        margin: auto;
        padding: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
      "
    >
      <div class="row wrap justify-start items-start content-start q-gutter-md">
        <q-intersection
          v-for="movie in movies"
          :key="movie.id"
          once
          transition="scale"
        >
          <q-card style="width: 400px; min-height: 500px; height: auto">
            <q-img
              :src="`https://image.tmdb.org/t/p/w300/${movie.backdrop_path}`"
              class="col"
              style="max-width 300px;height: 300px"
              ><div class="absolute-bottom text-h6">{{ movie.title }}</div>
            </q-img>
            <q-card-section>
              <p
                class="p"
                v-if="!movie.readActivated && movie.overview.length > 1"
              >
                {{ movie.overview.slice(0, 100)
                }}<span
                  class="text-primary"
                  v-if="!movie.readActivated"
                  @click="movie.readActivated = true"
                  >..mehr Anzeigen</span
                >
              </p>
              <p class="p" v-else-if="movie.readActivated">
                {{ movie.overview }}
                <span
                  class="text-primary"
                  v-if="movie.readActivated"
                  @click="movie.readActivated = false"
                  >..weniger Anzeigen</span
                >
              </p>

              <div class="text-subtitle">
                Veröffentlichung: {{ movie.release_date }}
              </div>
              <q-rating
                v-model="movie.vote_average"
                max="10"
                size="1.5em"
                color="green-4"
                icon="star_border"
                icon-selected="star"
                icon-half="star_half"
                class=""
                no-dimming
              />
            </q-card-section>
            <q-card-actions>
              <q-btn color="primary" @click="viewMovie(movie.id)">Mehr</q-btn>
            </q-card-actions>
          </q-card>
        </q-intersection>
      </div>
    </div>

    <q-btn
      v-if="search === ''"
      color="primary"
      @click="loadSearch()"
      :disable="!hasMore"
    >
      Load More
    </q-btn>
    <q-btn
      v-else-if="search != ''"
      color="primary"
      @click="loadSearch()"
      :disable="!hasMore"
    >
      Load More
    </q-btn>
  </q-page>
</template>

<script>
import axios from "axios";
import { useRoute, beforeRouteUpdate } from "vue-router";

export default {
  name: "MovieSearch",

  data() {
    return {
      movies: [],
      search: "",
      loading: false,
      hasMore: true,
      page: 1,
      componentKey: 0,
      API_KEY: "b64351ccceddb3a8d6fdb933ce0713d2",
    };
  },
  created() {
    console.log("Created: " + this.$router.currentRoute._value.query.search);
    const route = useRoute();

    const queryParam = route.query;
    this.search = queryParam.search;
    this.searchMovies();

    return { route };
  },

  methods: {
    getData() {
      console.log("yeah?");
    },
    searchMovies() {
      this.search = this.$router.currentRoute._value.query.search;
      this.page = 1;
      this.hasMore = true;
      this.loading = false;
      this.loadSearch();
    },
    viewMovie(id) {
      this.$router.push({ name: "movie", params: { id } });
    },
    async loadSearch() {
      if (this.loading || !this.hasMore) {
        return;
      }
      this.loading = true;
      try {
        const { data } = await axios.get(
          `https://api.themoviedb.org/3/search/movie?api_key=${this.API_KEY}&query=${this.search}&page=${this.page}`
        );
        this.movies = [...this.movies, ...data.results];
        this.hasMore = data.results.length === 20;
        this.page += 1;
      } catch (e) {
        console.log(e);
      } finally {
        this.loading = false;
      }
    },
  },
};
</script>
