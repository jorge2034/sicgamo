<template>
<q-page class="q-pa-xs">
<div class="row">
  <div class="col-12">
<!--    <iframe id="docpdf" src="" frameborder="0" style="width: 100%;height: 100vh"></iframe>-->
    <q-form @submit.prevent="consulta">
    <div class="row">
      <div class="col-3">
        <q-input dense outlined v-model="fecha1" type="date" label="fecha inicio"/>
      </div>
      <div class="col-3">
        <q-input dense outlined v-model="fecha2" type="date" label="fecha fin"/>
      </div>
      <div class="col-3">
        <q-select outlined v-model="tipodoc" label="Tipo documento" :options="optionstipodocs" style="max-width: 200px" dense options-dense>
            <template v-slot:prepend>
                <q-icon name="note_add" />
            </template>
          </q-select>
      </div>
      <div class="col-3 flex ">
        <!--    <q-input dense outlined v-model="fecha1" type="date"/>-->
        <q-btn dense type="submit" class="full-width" label="consulta" color="primary" icon="search"  />
      </div>
    </div>
  </q-form>
  </div>
  <div class="col-12">
    <q-table :filter="filter" dense square bordered flat title="Historial de correspondencia" :rows-per-page-options="[0]" :columns="columns" :rows="datos">
      <template v-slot:body-cell-citecontrol="props" >
        <q-td auto-width :props="props">
          <div class=""> {{props.row.fecha}}</div>
          <!-- <q-badge color="blue">
             <div class=""> {{props.row.hora}}</div>
          </q-badge> -->
          <div class="text-h5 text-bold"> {{props.row.mail.codigo}}</div>
          <div class="text-h6 text-bold"> {{props.row.mail.citecontrol}}</div>
        </q-td>
      </template>
      <template v-slot:body-cell-datos="props" >
        <q-td auto-width :props="props">
          <div class="">DE: {{props.row.user?props.row.user?.name:''}} </div>
          <div class="">A: {{props.row.user2.name}} | <q-badge color="blue">
             <div class=""> {{props.row.user2.unit.nombre}}</div>
          </q-badge></div>
          <p style="width:600px">REF: {{props.row.mail.ref.substr(0,100)}}</p>

          <div class="">
            <q-badge v-if="props.row.tipodoc!=null || props.row.tipodoc!='' || props.row.tipodoc!=undefined" :color="props.row.tipodoc==='NOTAS'?'teal-5':'amber-8'">Tipo: {{props.row.tipodoc}}</q-badge>
            <q-badge v-if="props.row.nfojas!=null" color="green">Num Fojas: {{props.row.nfojas}}</q-badge>
          </div>
        </q-td>
      </template>
      <template v-slot:body-cell-sello="props" >
        <q-td auto-width :props="props">
            <q-btn @click="dialogimpresionindividual=true" icon="print" color="info" />
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

    <q-dialog v-model="dialogimpresionindividual">
          <q-card style="width: 300px;min-width: 40vh">
            <q-card-section>
              <div class="text-h6"> <q-icon name="print"/>ELIJA LA POSICION PARA IMPRIMIR</div>
            </q-card-section>
            <q-card-section class="q-pt-none">
               <q-list bordered separator>
                  <q-item clickable v-ripple>
                    <q-item-section>
                      <q-item-label class="relative-position container bg-grey-3 text-black flex flex-center">1</q-item-label>
                    </q-item-section>
                  </q-item>
                  <q-item clickable v-ripple>
                    <q-item-section>
                      <q-item-label class="relative-position container bg-grey-3 text-black flex flex-center">2</q-item-label>
                    </q-item-section>
                  </q-item>
                  <q-item clickable v-ripple >
                    <q-item-section>
                      <q-item-label class="relative-position container bg-grey-3 text-black flex flex-center">3</q-item-label>
                    </q-item-section>
                  </q-item>
                  <q-item clickable v-ripple >
                    <q-item-section>
                      <q-item-label class="relative-position container bg-grey-3 text-black flex flex-center">4</q-item-label>
                    </q-item-section>
                  </q-item>
                  <q-item clickable v-ripple >
                    <q-item-section>
                      <q-item-label class="relative-position container bg-grey-3 text-black flex flex-center">5</q-item-label>
                    </q-item-section>
                  </q-item>
                  <q-item clickable v-ripple>
                    <q-item-section>
                      <q-item-label class="relative-position container bg-grey-3 text-black flex flex-center">6</q-item-label>
                    </q-item-section>
                  </q-item>
                  <q-item clickable v-ripple>
                    <q-item-section>
                      <q-item-label class="relative-position container bg-grey-3 text-black flex flex-center">7</q-item-label>
                    </q-item-section>
                  </q-item>
                </q-list>
            </q-card-section>
            <q-card-section align="right">
              <q-btn flat label="Cancelar" color="primary" icon="delete" v-close-popup />
            </q-card-section>
          </q-card>
    </q-dialog>

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
        {name:'sello',label:'Impresión individual',field:'sello'},
      ],
      datos:[],
      optionstipodocs:['TODO','NOTAS','MEMORANDUM','HOJA DE RUTA'],
      tipodoc:'TODO',
      dialogimpresionindividual:false,
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
      this.$axios.post(process.env.API+'/reportecorrespondenciaremitida',{
        fecha1:this.fecha1,
        fecha2:this.fecha2,
        tipodoc:this.tipodoc
      }).then(res=>{
        this.datos=[]
        this.$q.loading.hide()
        // console.log(res.data)
        res.data.forEach(r=>{
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
      doc.text('REMISIÓN ',43,17)
      doc.text('RECEPCION ',172,17)

      doc.setTextColor(158,158,158)
      doc.setFontSize(10);
      doc.text('HOJA '+numhoja,187,14)
      doc.setFontSize(7);
      doc.text('HOJA DE RUTA',184,17)
      doc.setTextColor(0,0,0)
      let i=0
      this.datos.forEach(d=>{
        cont++
        doc.roundedRect(8, 20+i*34, 194, 34, 0, 0, 'S')
        doc.line(40, 20+i*34, 40, 54+i*34)//line1
        doc.line(160, 20+i*34, 160, 54+i*34)//line1
        doc.setFontSize(10);
        doc.setFont('times', 'normal');
        doc.text(d.fecha.toString(),23,25+i*34,'center')
        doc.text(d.hora.toString(),23,30+i*34,'center')
        doc.setFont('times', 'bold');
        doc.setFontSize(12);
        doc.text(d.mail.codigo.toString(),23,38+i*34,'center')
        doc.setFontSize(10);
        doc.text(d.mail.citecontrol.toString(),23,43+i*34,'center')


        // doc.setFont('times', 'bold');
        doc.setFont('times', 'bold');
        doc.text('DE: '+d.user?.name,41,25+i*34,'left')
        doc.text('A: '+d.user2.name+' | ('+d.user2.unit.codigo+')',41,30+i*34,'left')
        doc.setFont('times', 'normal');
        doc.setFontSize(8);
        doc.text('REF: '+d.mail.ref.substr(0,60),41,35+i*34,'left')
        doc.text(d.mail.ref.substr(60,60),41,38+i*34,'left')
        doc.text(d.mail.ref.substr(120,60),41,41+i*34,'left')
        doc.text(d.mail.ref.substr(180,60),41,44+i*34,'left')
        doc.text(d.mail.ref.substr(240,60),41,47+i*34,'left')
        doc.setFontSize(9);
         doc.setFont('times', 'bold');
        if(d.tipodoc!=null || d.tipodoc!=''){
          doc.text('TIPO: '+d.tipodoc,41,52+i*34,'left')
        }
         doc.setFont('times', 'normal');
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
    impresionporhoja(n){
      consoloe.log(n)
    }
  }
}
</script>

<style scoped>

</style>
