<style scoped lang="scss">

</style>

<template>
  <v-container fluid>
    <v-card class="mx-auto my-2 lighten-4" max-width="800" tile>
      <v-card-title class="headline mb-1">Connect with CA</v-card-title>

      <p>
        Scan the QR code using a FHWA vehicle end to establish a
        connection with the CA.
      </p>

      <p>
        Once a connection is established, the credential issuance process will
        start automatically.
      </p>

      <v-progress-circular v-if="qrKey === 0" :indeterminate="true" rotate="true" size="32" width="4"
        color="secondary darken-2" class="mx-3"></v-progress-circular>

      <QRCode v-if="qrKey > 0" :value="inviteURL" :width="width" :key="qrKey" />

            <v-divider class="mx-4"></v-divider>

      <v-container fluid>
        <v-row align="center" justify="space-between" class="mr-2">
          <v-col cols="6" md="2">
            <v-btn outlined color="error" :to="{ path: 'confirm-data' }">Back</v-btn>
          </v-col>
          <v-col cols="6" md="2"> </v-col>
        </v-row>
      </v-container>
    </v-card>
  </v-container>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import QRCode from "@/components/QRCode.vue";
import { Connection, ConnectionStatus } from "../models/connection";
import Axios, { CancelTokenSource } from "axios";
import { AppConfig } from "@/models/appConfig";
import * as ConfigService from "@/services/config";

@Component({ components: { QRCode } })
export default class Connect extends Vue {
  private base64Invitation!: string;
  private inviteURL!: string;
  private width!: number;
  private qrKey = 0;
  private cancelTokenSource!: CancelTokenSource;
  private deeplinkPrefix = "didcomm://launch"

  created() {
    this.width = 300;
    this.base64Invitation = "Loading invite...";

    this.cancelTokenSource = Axios.CancelToken.source();

    ConfigService.getAppConfig().then(config => {
      // load deeplink prefix from store
      this.deeplinkPrefix = config.deepLinkPrefix ?? this.deeplinkPrefix
    })

    this.$store
      .dispatch("connection/getNewConnection")
      .then((result: Connection) => {
        
        //this.base64Invitation = JSON.stringify(qrCodeData);
        //console.log("Base64 encoded invitation:", this.base64Invitation);
        this.base64Invitation = btoa(JSON.stringify(result.invite));
        const qrCodeData = {
          invitation_url:  window.location.origin + "?c_i=" + this.base64Invitation,
          agent: 'ca'
        }; 
        this.inviteURL = JSON.stringify(qrCodeData);
        this.qrKey += 1; // force refresh of qrcode component
      });
  }

  updated() {
    this.$store
      .dispatch("connection/waitForConnectionStatus", {
        status: [ConnectionStatus.RESPONSE, ConnectionStatus.ACTIVE],
        cancelToken: this.cancelTokenSource.token
      })
      .then(() => {
        this.$router.push({ path: "issue-credential" });
      });
  }

  beforeDestroy() {
    // cancelling pending requests, if any
    this.cancelTokenSource.cancel();
  }
}
</script>
