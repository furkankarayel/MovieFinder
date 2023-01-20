<template>
  <q-page>
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
      <q-input v-model="search" label="Search" @keyup.enter="searchMovies" />
      <div class="row wrap justify-start items-start content-start q-gutter-md">
        <q-intersection
          v-for="movie in movies"
          :key="movie.id"
          once
          transition="scale"
        >
          <q-card style="width: 400px; height: 500px">
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
      @click="loadMoreMain()"
      :disable="!hasMore"
    >
      Load More
    </q-btn>
    <q-btn
      v-else-if="search != ''"
      color="primary"
      @click="loadMoreSearch()"
      :disable="!hasMore"
    >
      Load More
    </q-btn>
  </q-page>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      search: "",
      movies: [],
      loading: false,
      hasMore: true,
      page: 1,
      API_KEY: "b64351ccceddb3a8d6fdb933ce0713d2",
    };
  },
  mounted() {
    this.loadDiscoverMovies();
  },
  methods: {
    searchMovies() {
      this.movies = [];
      this.page = 1;
      this.hasMore = true;
      this.loadMoreSearch();
    },
    async loadDiscoverMovies() {
      axios
        .get(
          `https://api.themoviedb.org/3/discover/movie?api_key=${this.API_KEY}&language=de-DE`
        )
        .then((response) => {
          const moviesResponse = response.data.results;
          for (const post of moviesResponse) {
            post.readActivated = false;
          }
          this.movies = moviesResponse;

          console.log(this.movies);
        });
    },
    viewMovie(id) {
      this.$router.push({ name: "movie", params: { id } });
    },
    async loadMoreMain() {
      if (this.loading || !this.hasMore) {
        return;
      }
      this.loading = true;

      try {
        this.page += 1;
        const { data } = await axios.get(
          `https://api.themoviedb.org/3/discover/movie?api_key=${this.API_KEY}&language=de-DE&page=${this.page}`
        );
        this.movies = [...this.movies, ...data.results];
        this.hasMore = data.results.length === 20;
      } catch (e) {
        console.log(e);
      } finally {
        this.loading = false;
      }
    },
    async loadMoreSearch() {
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
