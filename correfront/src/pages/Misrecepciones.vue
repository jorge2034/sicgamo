<template>
<q-page class="q-pa-xs">
  <div class="row">
    <div class="col-12">
      <q-form @submit.prevent="consultar()">
        <div class="row">
          <div class="col-4 q-pa-xs"><q-input outlined v-model="fecha1" type="date" label="Fecha inicio"/></div>
          <div class="col-4 q-pa-xs"><q-input outlined v-model="fecha2" type="date" label="Fecha final"/></div>
          <div class="col-4 q-pa-xs flex flex-center">
            <q-btn label="consulta" color="primary" icon="search" type="submit"/>
          </div>
        </div>
      </q-form>
    </div>
    <div class="col-12">
      <table id="example" style="width:100%">
        <thead>
        <tr>
          <th>Fecha</th>
          <th>Codigo</th>
          <th>Referencia</th>
          <th>Remitente</th>
          <th>Cargo</th>
          <th>Institucion</th>
          <th>Fecha carta</th>
          <th>Codigo externo</th>
<!--          <th>Historial</th>-->
        </tr>
        </thead>
        <tbody>
        <tr v-for="(mail,i) in mails" :key="i">
          <td>{{mail.fecha}} {{mail.hora}}</td>
          <td>{{mail.codigo}}</td>
          <td>{{mail.ref}}</td>
          <td>{{mail.remitente}}</td>
          <td>{{mail.cargo}}</td>
          <td>{{mail.institucion}}</td>
          <td>{{mail.fechacarta}}</td>
          <td>{{mail.codexterno}}</td>
<!--          <td>-->
<!--            <ul style="padding: 0px;margin: 0px;border: 0px;">-->
<!--              <li style="padding: 0px;margin: 0px;border: 0px;font-size: 8px;list-style: none" v-for="l in mail.logs" :key="l.id">{{l.destinatario}}</li>-->
<!--            </ul>-->
<!--          </td>-->
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</q-page>
</template>

<script>
var $  = require( 'jquery' );
require( 'datatables.net-buttons/js/buttons.html5.js' )();
require( 'datatables.net-buttons/js/buttons.print.js' )();
require('datatables.net-buttons/js/dataTables.buttons');
require('datatables.net-dt/css/jquery.dataTables.min.css');
import print from 'datatables.net-buttons/js/buttons.print';
import jszip from 'jszip/dist/jszip';
import pdfMake from 'pdfmake/build/pdfmake';
import pdfFonts from 'pdfmake/build/vfs_fonts';
pdfMake.vfs=pdfFonts.pdfMake.vfs;
window.JSZip=jszip;
import {date} from 'quasar'
export default {
  data(){
    return {
      fecha1:date.formatDate(Date.now(),'YYYY-MM-DD'),
      fecha2:date.formatDate(Date.now(),'YYYY-MM-DD'),
      mails:[]
    }
  },
  created() {

  },
  mounted() {
    $('#example').DataTable( {
      dom: 'Bfrtip',
      buttons: [
        'copy', 'csv', 'excel', 'pdf', 'print'
      ]
    })
    this.consultar()
  },
  methods:{
    consultar(){
      this.$q.loading.show()
      this.$axios.post(process.env.API+'/consulta',{fecha1:this.fecha1,fecha2:this.fecha2}).then(res=>{
        // console.log(res.data)
        this.mails=res.data
        this.$q.loading.hide()
        $('#example').DataTable().destroy();
        this.$nextTick(()=> {
          $('#example').DataTable({
            dom: 'Bfrtip',
            buttons: [
              'copy', 'csv', 'excel', 'pdf', 'print'
            ]
          })
        })
      }).catch(err=>{
        this.$q.loading.hide()
        this.$q.notify({
          message:err.response.data.message,
          color:'red',
          icon:'error'
        })
      })
    }
  }

}
</script>

<style scoped>

</style>
