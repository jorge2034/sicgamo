<template>
<q-page class="q-pa-xs">
<div class="row">
  <div class="col-12">
<!--    <iframe id="docpdf" src="" frameborder="0" style="width: 100%;height: 100vh"></iframe>-->
    <q-form @submit.prevent="consulta">
    <div class="row">
      <div class="col-4">
        <q-input dense outlined v-model="fecha1" type="date" label="fecha inicio"/>
      </div>
      <div class="col-4">
        <q-input dense outlined v-model="fecha2" type="date" label="fecha fin"/>
      </div>
      <div class="col-4 flex ">
        <!--    <q-input dense outlined v-model="fecha1" type="date"/>-->
        <q-btn type="submit" class="full-width" label="consulta" color="primary" icon="search"  />
      </div>
    </div>
  </q-form>
  </div>
  <div class="col-12">
    <q-table :filter="filter" dense square bordered flat title="Historial de correspondencia archivada" :rows-per-page-options="[0]" :columns="columns" :rows="datos">
      <template v-slot:body-cell-citecontrol="props" >
        <q-td auto-width :props="props">
          <div class=""> {{props.row.fecha}}</div>
          <div class="" dense> {{props.row.hora}}</div>
          <div class="text-h5 text-bold"> {{props.row.mail.codigo}}</div>
          <div class="text-h6 text-bold"> {{props.row.mail.citecontrol}}</div>
        </q-td>
      </template>
      <template v-slot:body-cell-datos="props" >
        <q-td auto-width :props="props">
          <div class="">DE: {{!props.row.user?"":props.row.user?.name}}| <q-badge color="blue">
             <div class="">{{!props.row.user?"CREADO POR EL USUARIO":props.row.user.unit.nombre}}</div>
          </q-badge> </div>
          <div class="">A: {{props.row.user2.name}} </div>
          <div class="">REF: {{props.row.mail.ref}}</div>
          <div class="">ARCHIVADO: {{props.row.archivado}}</div>
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

export default {
  name: `Reportecorrespondencia`,
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
      this.$axios.post(process.env.API+'/reportecorrespondenciaarchivada',{
        fecha1:this.fecha1,
        fecha2:this.fecha2,
      }).then(res=>{
        this.datos=[]
        this.$q.loading.hide()
        // console.log(res.data)
        res.data.forEach(r=>{
          r.datos=r.destinatario+r.remitente+r.ref
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
      let cont=0
      doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
      doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
      doc.setFontSize(10);
      doc.text('CITE ',18,17)
      doc.text('CODIGO ',52,17)
      doc.text('PROCEDENCIA Y REFERENCIA ',93,17)
      doc.setTextColor(158,158,158)
      doc.setFontSize(10);
      doc.text('HOJA '+numhoja,187,14)
      doc.setFontSize(7);
      doc.text('HOJA DE RUTA',184,17)
      doc.setTextColor(0,0,0)
      let i=0
      let remitente=''
      let unidad=''
      this.datos.forEach(d=>{
        cont++
        doc.roundedRect(8, 20+i*34, 194, 34, 0, 0, 'S')
        doc.line(40, 20+i*34, 40, 54+i*34)//line1
        doc.line(80, 20+i*34, 80, 54+i*34)//line1
        doc.setFontSize(12);
         doc.setFont('times', 'normal');
        doc.text(d.mail.fecha.toString(),23,25+i*34,'center')
        doc.text(d.mail.hora.toString(),23,30+i*34,'center')

        doc.setFontSize(12);
        doc.setFont('times', 'bold');
        doc.text(d.mail.citecontrol.toString(),23,38+i*34,'center')
        doc.setFontSize(12);
        doc.text(d.mail.codigo.toString(),58,38+i*34,'center')
        doc.setFont('times', 'normal');

        doc.setFontSize(10);
         doc.setFont('times', 'bold');
         remitente = d.user===null?"CREADO POR EL USUARIO":d.user.name
        doc.text('DE: '+remitente,82,25+i*34,'left')
        unidad = d.user===null?d.user2.unit.nombre:d.user.unit.nombre
        doc.text('UNIDAD: '+unidad,82,30+i*34,'left')
        doc.setFont('times', 'normal');
        doc.text('REF: '+d.mail.ref.substr(0,50),82,35+i*34,'left')
        doc.text(d.mail.ref.substr(50,50),82,40+i*34,'left')
        doc.text(d.mail.ref.substr(100,50),82,45+i*34,'left')
        doc.text('ARCHIVADO: '+d.archivado.substr(150,50),82,50+i*34,'left')
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
          doc.text('HOJA DE RUTA',184,17)
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
