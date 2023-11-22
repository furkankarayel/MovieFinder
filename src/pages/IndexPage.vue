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
              ><div class="absolute-bottom text-h6 text-white">
                {{ movie.title }}
              </div>
            </q-img>
            <q-card-section>
              <p
                class="text"
                v-if="!movie.readActivated && movie.overview.length > 1"
              >
                {{ movie.overview.slice(0, 150) }}
                <br />

                <span
                  v-if="!movie.readActivated"
                  @click="movie.readActivated = true"
                  style="
                    color: blue;
                    text-decoration: underline;
                    cursor: pointer;
                    font-size: 0.75rem; /* Adjust the font size as needed */
                  "
                >
                  mehr Anzeigen
                </span>
              </p>
              <p class="text" v-else-if="movie.readActivated">
                {{ movie.overview }}
                <br />
                <span
                  v-if="movie.readActivated"
                  @click="movie.readActivated = false"
                  style="
                    color: blue;
                    text-decoration: underline;
                    cursor: pointer;
                    font-size: 0.75rem; /* Adjust the font size as needed */
                  "
                  >weniger Anzeigen</span
                >
              </p>
            </q-card-section>
            <q-card-actions>
              <q-btn color="primary" size="md" @click="viewMovie(movie.id)"
                >Mehr Info</q-btn
              >
            </q-card-actions>
          </q-card>
        </q-intersection>
      </div>
    </div>
    <div
      style="display: flex; justify-content: center; align-items: center"
      class="q-pa-lg"
    >
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
    </div>
    <q-dialog v-model="detail">
      <q-card style="width: 400px; min-height: 500px; height: auto">
        <q-img
          :src="`https://image.tmdb.org/t/p/w300/${movieDetail.backdrop_path}`"
          class="col"
          style="max-width 150px;height: 200px"
        />

        <q-card-section>
          <div class="text-h4 q-pb-md">{{ movieDetail.title }}</div>

          <q-separator />
          <p class="q-pt-md">
            {{ movieDetail.overview }}
          </p>
        </q-card-section>
        <q-card-section>
          Genres:
          <q-chip
            square
            outline
            color="primary"
            class="q-pa-xs"
            v-for="genre in movieDetail.genres"
            :key="genre.id"
          >
            {{ genre.name }}
          </q-chip>
        </q-card-section>
        <q-separator />
        <q-card-section>
          <q-rating
            v-model="movieDetail.vote_average"
            max="10"
            size="1.5em"
            color="green-4"
            icon="star_border"
            icon-selected="star"
            icon-half="star_half"
            class=""
            no-dimming
          />
          <div class="q-pa-xs">{{ movieDetail.vote_count }} Bewertungen</div>
        </q-card-section>
      </q-card>
    </q-dialog>
  </q-page>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      search: "",
      movies: [],
      genres: [],
      movieDetail: [],
      loading: false,
      hasMore: true,
      page: 1,
      detail: false,
      API_KEY: "b64351ccceddb3a8d6fdb933ce0713d2",
    };
  },
  mounted() {
    this.loadDiscoverMovies();
    this.loadGenres();
  },
  methods: {
    searchMovies() {
      this.movies = [];
      this.movieDetail = [];
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
        });
    },
    async loadGenres() {
      axios
        .get(
          `https://api.themoviedb.org/3/genre/movie/list?api_key=${this.API_KEY}&language=de-DE`
        )
        .then((response) => {
          const genresResponse = response.data.genres;
          this.genres = genresResponse;
        });
    },
    viewMovie(id) {
      this.movieDetail = this.movies.find((element) => element.id === id);

      let genresWithName = [];
      let newMovieDetail = this.movieDetail;
      const detailGernes = this.movieDetail.genre_ids;
      for (var i = 0; i < detailGernes.length; i++) {
        let genreObject = this.genres.find(
          (element) => element.id === detailGernes[i]
        );
        genresWithName.push(genreObject);
      }

      newMovieDetail.genres = genresWithName;
      this.movieDetail = newMovieDetail;
      this.detail = true;
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
