<template>
<q-page class="q-pa-xs">
<div class="row">
  <div class="col-12">
<!--    <iframe id="docpdf" src="" frameborder="0" style="width: 100%;height: 100vh"></iframe>-->
    <q-form @submit.prevent="consulta">
    <div class="row">

      <div class="col-12 flex ">
        <!--    <q-input dense outlined v-model="fecha1" type="date"/>-->
        <q-btn type="submit" class="full-width" label="consulta" color="primary" icon="search"  />
      </div>
    </div>
  </q-form>
  </div>
  <div class="col-12">
    <q-table :filter="filter" dense square bordered flat title="Historial de correspondencia" :rows-per-page-options="[10]" :columns="columns" :rows="datos">
      <template v-slot:body-cell-citecontrol="props" >
        <q-td auto-width :props="props">
          <div class="text-h6 text-bold"> {{props.row.mail.codigo}}</div>
          <div class="text-h6 text-bold"> {{props.row.mail.citecontrol}}</div>
        </q-td>
      </template>
      <template v-slot:body-cell-datos="props" >
        <q-td auto-width :props="props">
          <div class="">DE: {{!props.row.user?"":props.row.user.name}} | <q-badge color="blue">
             <div class=""> {{!props.row.user?"CREADO POR EL USUARIO":props.row.user.unit.nombre}}</div>
          </q-badge> </div>
          <div class="">REF: {{props.row.mail.ref}}</div>
          <div class="">ESTADO:
            <q-badge v-if="props.row.estado=='ACEPTADO'" color="green">{{props.row.estado}}</q-badge>
            <q-badge v-if="props.row.estado=='EN PROCESO'" color="deep-orange-7"> {{props.row.estado}}</q-badge>
          </div>
          <template v-if="props.row.estado=='ACEPTADO'">
          <div class="">REMITIDO: {{props.row.dias}} ({{props.row.fecha}}) Y ACEPTADO: {{props.row.dias}} ({{ new Date(props.row.updated_at).toISOString().slice(0, 10).replace('T', ' ')}})</div>
          </template>
          <template v-if="props.row.estado=='EN PROCESO'">
          <div class="">REMITIDO: {{props.row.dias}} ({{props.row.fecha}}) POR {{!props.row.user?"":props.row.user.name}} ({{!props.row.user?"CREADO POR EL USUARIO":props.row.user.unit.nombre}})</div>
          </template>
        </q-td>
      </template>
      <template v-slot:top-right>
        <q-btn @click="impresion" icon="print" label="imprimir" color="positive" />
        <q-input outlined dense  v-model="filter" placeholder="Buscar">
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
      </template>
    </q-table>
  </div>
</div>
</q-page>
</template>
<script>
import {date} from "quasar"
import {jsPDF} from "jspdf";
import $ from 'jquery'
import { format, render, cancel, register } from 'timeago.js';
export default {
  name: `Reportecorrespondenciapendiente`,
  data(){
    return{
      filter:'',
      fecha1:date.formatDate(new Date(),'YYYY-MM-DD'),
      fecha2:date.formatDate(new Date(),'YYYY-MM-DD'),
      columns:[
        {name:'citecontrol',label:'citecontrol',field:'citecontrol',align: 'center'},
        {name:'datos',label:'datos',field:'datos',align:'left'},
        {name:'sello',label:'sello',field:'sello'},
      ],
      datos:[]
    }
  },
  created() {
    this.consulta()

  },
  mounted() {
    // this.impresion()
  },
  methods:{
    consulta(){
      this.$q.loading.show()
      register('es_ES', (number, index, total_sec) => [
          ['justo ahora', 'ahora mismo'],
          ['hace %s segundos', 'en %s segundos'],
          ['hace 1 minuto', 'en 1 minuto'],
          ['hace %s minutos', 'en %s minutos'],
          ['hace 1 hora', 'en 1 hora'],
          ['hace %s horas', 'in %s horas'],
          ['hace 1 dia', 'en 1 dia'],
          ['hace %s dias', 'en %s dias'],
          ['hace 1 semana', 'en 1 semana'],
          ['hace %s semanas', 'en %s semanas'],
          ['hace 1 mes', 'en 1 mes'],
          ['hace %s meses', 'en %s meses'],
          ['hace 1 año', 'en 1 año'],
          ['hace %s años', 'en %s años']
        ][index]);
      this.$axios.post(process.env.API+'/reportecorrespondenciapendiente',{
        fecha1:this.fecha1,
        fecha2:this.fecha2,
      }).then(res=>{
        this.datos=[]
        this.$q.loading.hide()
        // console.log(res.data)
        res.data.forEach(r=>{
          r.datos=r.destinatario+r.remitente+r.ref
          if(r.estado=='ACEPTADO'){

            r.dias = format(r.updated_at,'es_ES')
          }
          if(r.estado=='EN PROCESO'){
            r.dias = format(r.fecha+' '+r.hora,'es_ES')
          }
          this.datos.push(r)
        })
        console.log("datos: ",this.datos)
        // this.datos=res.data
      })
    },
    impresion(){
      // console.log(l)
      this.$q.loading.show()
      // this.$axios.get(process.env.API+'/mail/'+l.mail_id).then(res=>{
      //   let m=res.data

        var doc = new jsPDF()


        doc.setFont('times', 'bold');
        doc.setDrawColor(122);
      let numhoja=1
      let cont=0,contador=0
      let remitente=''
      let unidad=''
      let fechaestado=''
      let ref=''
      doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
      doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
      doc.setFontSize(10);
      console.log('store',this.$store.state.login.user)
      doc.text(this.$store.state.login.user.name+' - '+this.$store.state.login.user.unit.nombre,8,8)
      doc.text('CITE/CODIGO ',12,17)
      doc.text('CORRESPONDENCIA PENDIENTE',52,17)
      doc.setTextColor(158,158,158)
      doc.setFontSize(10);
      doc.text('HOJA '+numhoja,187,14)
      doc.setFontSize(7);
      doc.text('REPORTE',187,17)
      doc.setTextColor(0,0,0)
      let i=0
      this.datos.forEach(d=>{
        cont++
        contador++
        doc.roundedRect(8, 20+i*34, 194, 34, 0, 0, 'S')
        doc.line(40, 20+i*34, 40, 54+i*34)//line1
        //doc.line(80, 20+i*34, 80, 54+i*34)//line1
        doc.setFontSize(12);
         doc.setFont('times', 'normal');
        // doc.text(d.mail.fecha.toString(),23,25+i*34,'center')
        // doc.text(d.mail.hora.toString(),23,30+i*34,'center')


        doc.setFontSize(13)
        doc.setFont('times', 'bold');
        doc.roundedRect(9, 21+i*34, 8, 8,1, 1, 'S')
        doc.text(contador.toString(),13,27+i*34,'center')

        doc.text(d.mail.citecontrol.toString(),23,38+i*34,'center')
        doc.text(d.mail.codigo.toString(),23,45+i*34,'center')
        doc.setFont('times', 'normal');

        doc.setFontSize(10);
        remitente = d.user===null?"CREADO POR EL USUARIO":d.user.name
        doc.text('DE: '+remitente,42,25+i*34,'left')
        unidad = d.user===null?d.user2.unit.nombre:d.user.unit.nombre
        doc.text('UNIDAD: '+unidad,42,30+i*34,'left')

        doc.text('ESTADO: ',42,35+i*34,'left')
        doc.setFontSize(8);
        if(d.estado =='ACEPTADO'){
          doc.setTextColor(255,0,0);
          doc.text(d.estado,58,35+i*34,'left')
          fechaestado = new Date(d.updated_at).toISOString().slice(0, 10).replace('T', ' ')
          doc.roundedRect(144, 21+i*34, 57, 8,1, 1, 'S')
          doc.text('Remitido '+d.dias + ' ('+d.fecha+')' ,145,25+i*34,'left')
          doc.setTextColor(0,0,255);
          doc.text('Aceptado '+d.dias + ' ('+fechaestado+')' ,145,28+i*34,'left')
        }
        doc.setFontSize(10);
        if(d.estado =='EN PROCESO'){
          doc.setTextColor(255,0,0);
          doc.text(d.estado,58,35+i*34,'left')
          doc.roundedRect(144, 21+i*34, 57, 6,1, 1, 'S')
          doc.text('Remitido '+d.dias + ' ('+d.fecha+')' ,145,25+i*34,'left')
        }
        doc.setTextColor(0,0,0);
        doc.setFont('times', 'normal');


        ref = doc.splitTextToSize('REF: '+ d.mail.ref.substr(0,300),155)
        doc.text(ref,42,40+i*34,'left')

        // doc.text('REF: '+d.mail.ref.substr(0,70),42,40+i*34,'left')
        // doc.text(d.mail.ref.substr(70,70),42,45+i*34,'left')
        // doc.text(d.mail.ref.substr(140,70),42,50+i*34,'left')
        doc.setFontSize(10);
        i++
        if (cont==8){
          i=0
          cont=0
          numhoja++
          doc.addPage()
          doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
          doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
          doc.setTextColor(158,158,158)
          doc.setFont('times', 'bold');
          doc.setFontSize(10);
          doc.text('HOJA '+numhoja,187,14)
          doc.setFontSize(7);
          doc.text('REPORTE',187,17)
          doc.setTextColor(0,0,0)
          doc.setFont('times', 'normal');
          // if (cont>8){
          //
          // }
        }

      })


        window.open(doc.output('bloburl'), '_blank');
      this.$q.loading.hide()

    },
  }
}
</script>

<style scoped>

</style>
