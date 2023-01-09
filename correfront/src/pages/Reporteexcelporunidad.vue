<template>
<q-page class="q-pa-xs">
<div class="row">
  <div class="col-12">
<!--    <iframe id="docpdf" src="" frameborder="0" style="width: 100%;height: 100vh"></iframe>-->
    <q-form @submit.prevent="descargarexcel">
    <div class="row">
      <div class="col-3">
        <q-input dense outlined v-model="fecha1" type="date" label="fecha inicio"/>
      </div>
      <div class="col-3">
        <q-input dense outlined v-model="fecha2" type="date" label="fecha fin"/>
      </div>
      <div class="col-3 flex ">
        <!--    <q-input dense outlined v-model="fecha1" type="date"/>-->
        <!-- <q-btn dense type="submit" class="full-width" label="consulta" color="primary" icon="search"  /> -->
        <q-btn @click="descargarexcel" icon="table_view" label="Descargar excel " color="positive"></q-btn>
      </div>
    </div>
  </q-form>
  </div>

</div>
</q-page>
</template>
<script>
import {date} from "quasar"
import {jsPDF} from "jspdf";
import $ from 'jquery'

export default {
  name: `Reportecorrespondencia`,
  data(){
    return{
      filter:'',
      fecha1:date.formatDate(new Date(),'YYYY-MM-DD'),
      fecha2:date.formatDate(new Date(),'YYYY-MM-DD'),
    }
  },
  created() {

  },
  mounted() {
    // this.impresion()
  },
  methods:{
    descargarexcel() {
      this.$q.loading.show()
      this.$axios.get(process.env.API+`/reporteremitidosexcel?unidad=${this.$store.state.login.user.unit.id}&fecha1=${this.fecha1}&fecha2=${this.fecha2}`,
       {responseType: 'blob'})
   .then((response) => {
        let fileUrl = window.URL.createObjectURL(response.data);
        let fileLink = document.createElement('a');

        fileLink.href = fileUrl;
        fileLink.setAttribute('download', `correspondencia_${ this.$store.state.login.user.unit.nombre } ${new Date().toLocaleDateString()}.xls`);
        document.body.appendChild(fileLink)
        this.$q.loading.hide()

        fileLink.click();
    }).catch(error => {
        console.log(error.response.data)
    })
    },

  }
}
</script>

<style scoped>

</style>
