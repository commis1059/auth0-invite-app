<template>
    <div>
        <button @click="callPublic">Public</button>
        <button @click="callPrivate">Private</button>
        <button @click="callScoped">Scoped</button>
        <p>{{ apiMessage }}</p>
    </div>
</template>

<script>
import axios from "axios";

export default {
  name: "external-api",
  data() {
    return {
      apiMessage: ""
    };
  },
  methods: {
    async callPublic() {
      // Get the access token from the auth wrapper
      const token = await this.$auth.getTokenSilently();

      // Use Axios to make a call to the API
      const { data } = await axios.get("/api/public", {
        headers: {
          Authorization: `Bearer ${token}`    // send the access token through the 'Authorization' header
        }
      });

      this.apiMessage = data;
    },
    async callPrivate() {
      // Get the access token from the auth wrapper
      const token = await this.$auth.getTokenSilently();
      console.log(`private: ${token}`);

      // Use Axios to make a call to the API
      const { data } = await axios.get("/api/private", {
        headers: {
          Authorization: `Bearer ${token}`    // send the access token through the 'Authorization' header
        }
      });

      this.apiMessage = data;
    },
    async callScoped() {
      // Get the access token from the auth wrapper
      const token = await this.$auth.getTokenSilently();
      console.log(`scoped: ${token}`);

      // Use Axios to make a call to the API
      const { data } = await axios.get("/api/private-scoped", {
        headers: {
          Authorization: `Bearer ${token}`    // send the access token through the 'Authorization' header
        }
      });

      this.apiMessage = data;
    }
  }
};
</script>
