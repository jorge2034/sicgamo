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
    <q-table :filter="filter" dense square bordered flat title="Historial de correspondencia" :rows-per-page-options="[0]" :columns="columns" :rows="datos">
      <template v-slot:body-cell-citecontrol="props" >
        <q-td auto-width :props="props">
          <div class=""> {{props.row.fecha}}</div>
          <div class="text-h5 text-bold"> {{props.row.codigo}}</div>
          <div class="text-h6 text-bold"> {{props.row.citecontrol}}</div>
        </q-td>
      </template>
      <template v-slot:body-cell-datos="props" >
        <q-td auto-width :props="props">
          <div class="">DE: {{props.row.remitente}}</div>
          <div class="">A: {{props.row.destinatario}}</div>
          <div class="">REF: {{props.row.ref}}</div>
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
      this.$axios.post(process.env.API+'/reportecorrespondencia',{
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
        // this.datos=res.data
      })
    },
    impresion(){
      // console.log(l)
      this.$q.loading.show()
      // this.$axios.get(process.env.API+'/mail/'+l.mail_id).then(res=>{
      //   let m=res.data

        var doc = new jsPDF()
        // let x=0
        // let y=0
        // doc.setDrawColor(122);
        // doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
        // doc.roundedRect(8, 22, 194, 30, 2, 2, 'S')//destinatario 1
        // doc.roundedRect(58, 22, 20, 30, 2, 2, 'S')//el logo HR
        // doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
        // doc.setFillColor(158,158,158)
        // doc.line(8, 28, 58, 28)//line n
        // doc.line(8, 36, 58, 36)//line fecha recepcion
        // doc.line(8, 46, 58, 46)//line hora repeccion
        // doc.line(78, 26, 202, 26)//line remitente
        // doc.line(78, 31, 202, 31)//line entidad
        // doc.line(78, 36, 202, 36)//line CITE
        // doc.line(78, 41, 202, 41)//line referecnia
        // doc.line(78, 46, 202, 46)//line hojas
        // doc.roundedRect(70, 5, 70, 10, 2, 2, 'F') // fondo gamo
        // doc.setFontSize(35);
        // doc.setFont('times', 'bold');
        // doc.setTextColor(255,255,255)
        // doc.text('GAMO',85,14)
        // doc.setTextColor(0,0,0)
        // doc.setFontSize(37);
        // doc.text('HR',58,38)
        // doc.setFontSize(7);
        // doc.text('HOJA DE RUTA',59,42)
        // doc.setTextColor(158,158,158)
        // doc.setFontSize(10);
        // doc.text('HOJA 1',187,14)
        // doc.setFontSize(7);
        // doc.text('HOJA DE RUTA',184,17)
        // doc.setTextColor(0,0,0)
        // doc.setFontSize(11)
        // doc.text('REGISTRO DE CORRESPONDENCIA - HOJA DE RUTA',58,20)
        // doc.setFontSize(15)
        // doc.text('Nº',10,27)
        // doc.setFont(undefined, 'normal');
        // doc.text('COLOCADO LA EL CODIGO',40,27,'center')
        // doc.setFont('times', 'bold');
        // doc.setFontSize(10)
        // doc.text(['FECHA DE','RECEPCION:'],10,31)
        // doc.setFont(undefined, 'normal');
        // doc.text(l.fecha.toString(),45,33,'center')
        // doc.setFont('times', 'bold');
        // doc.text(['HORA DE','RECEPCION:'],10,40)
        // doc.setFont(undefined, 'normal');
        // doc.text(l.hora.toString(),45,42,'center')
        // doc.setFont('times', 'bold');
        // doc.text('CITE:',10,49)
        // doc.setFont('times', 'normal');
        // doc.setFontSize(14)
        // doc.text(m.citecontrol.toString(),45,50,'center')
        // doc.setFontSize(10)
        // doc.setFont('times', 'bold');
        // doc.text('REMITENTE:',80,25)
        // doc.setFont('times', 'normal');
        // doc.text(m.remitente,152,25,'center')
        // doc.setFont('times', 'bold');
        // doc.text('ENTIDAD:',80,30)
        // doc.setFont('times', 'normal');
        // doc.text(m.institucion,152,30,'center')
        // doc.setFont('times', 'bold');
        // doc.text('CITE ENTRANTE:',80,35)
        // doc.setFont('times', 'normal');
        // doc.text(m.cite,130,35,'center')
        // doc.setFont('times', 'bold');
        // doc.text('HOJAS:',150,35)
        // doc.setFont('times', 'normal');
        // doc.text(m.folio,170,35,'center')
        // doc.setFont('times', 'bold');
        // doc.text('REF:',80,40)
        // doc.setFont('times', 'normal');
        // doc.text([m.ref.substring(0,50),m.ref.substring(50,100)],148,40,'center')
        // doc.setFont('times', 'bold');
        // doc.text('DESTINATARIO 1:',80,50)
        // doc.setFont(undefined, 'normal');
        // doc.text(l.user2.name,152,50,'center')
        // doc.setFont('times', 'bold');
        //FIN CABEZERA
        //INICIO CORRESPONDENCIA
        // let con=2
        // for (let i=0;i<3;i++){
        //   doc.roundedRect(8, 52+i*80, 194, 80, 2, 2, 'S')
        //
        //   doc.setFontSize(6)
        //   doc.text(['ATENDRE TRAMITE DE','A CUERDO','A PROCEDIMIENTO','VIGENTE Y NORMATIVA'],21,54+i*80,{align:'center'})
        //   doc.setFontSize(10)
        //   doc.text('RESPONDER',21,69+i*80,{align:'center'})
        //   doc.text('INFORME',21,79+i*80,{align:'center'})
        //   doc.text('TOME ACCION',21,89+i*80,{align:'center'})
        //   doc.text('NOTIFICAR',21,99+i*80,{align:'center'})
        //   doc.setFontSize(6)
        //   doc.text(['PROCESAR CONFORME','EL PROVEIDO QUE','ANTECEDE'],21,106+i*80,{align:'center'})
        //   doc.setFontSize(9)
        //   doc.text(['PROYECTAR','NOTA'],21,117+i*80,{align:'center'})
        //   doc.text('ARCHIVAR',21,129+i*80,{align:'center'})
        //   doc.roundedRect(35, 52+i*80, 5, 10, 1, 1, 'S')
        //   doc.line(8, 62+i*80, 40, 62+i*80)//line1
        //   doc.roundedRect(35, 62+i*80, 5, 10, 1, 1, 'S')
        //   doc.line(8, 72+i*80, 40, 72+i*80)//line2
        //   doc.roundedRect(35, 72+i*80, 5, 10, 1, 1, 'S')
        //   doc.line(8, 82+i*80, 40, 82+i*80)//line3
        //   doc.roundedRect(35, 82+i*80, 5, 10, 1, 1, 'S')
        //   doc.line(8, 92+i*80, 40, 92+i*80)//line4
        //   doc.roundedRect(35, 92+i*80, 5, 10, 1, 1, 'S')
        //   doc.line(8, 102+i*80, 40, 102+i*80)//line5
        //   doc.roundedRect(35, 102+i*80, 5, 10, 1, 1, 'S')
        //   doc.line(8, 112+i*80, 40, 112+i*80)//line5
        //   doc.roundedRect(35, 112+i*80, 5, 10, 1, 1, 'S')
        //   doc.line(8, 122+i*80, 40, 122+i*80)//line6
        //   doc.roundedRect(35, 122+i*80, 5, 10, 1, 1, 'S')
        //
        //   doc.text('INSTRUCCIONES:',85,55+i*80,{align:'center'})
        //   doc.text('_________________',85,55+i*80,{align:'center'})
        //   doc.text('.................................................................................................................',40,62+i*80)
        //   doc.text('.................................................................................................................',40,67+i*80)
        //   doc.text('.................................................................................................................',40,72+i*80)
        //   doc.text('.................................................................................................................',40,77+i*80)
        //   doc.text('.................................................................................................................',40,82+i*80)
        //   doc.text('.................................................................................................................',40,87+i*80)
        //   doc.text('.................................................................................................................',40,92+i*80)
        //   doc.text('.................................................................................................................',40,97+i*80)
        //   doc.text('.................................................................................................................',40,102+i*80)
        //   doc.text('.................................................................................................................',40,107+i*80)
        //   doc.text('.................................................................................................................',40,112+i*80)
        //   doc.text('.................................................................................................................',40,117+i*80)
        //   doc.text('.................................................................................................................',40,122+i*80)
        //   doc.text('.................................................................................................................',40,127+i*80)
        //   doc.text('FIRMAR',115,130+i*80)
        //
        //   doc.roundedRect(130, 52+i*80, 72, 80, 1, 1, 'S')
        //   doc.line(130, 59+i*80, 202, 59+i*80)//line1
        //   doc.line(130, 126+i*80, 202, 126+i*80)//line2
        //   doc.text('DESTINATARIO '+con+':',132,57+i*80)
        //   doc.text('SELLO DE RECEPCION '+con+':',150,125+i*80)
        //   doc.text('FECHA:',132,130+i*80)
        //   doc.text('HORA:',172,130+i*80)
        //   con++
        // }
        //
        // doc.addPage();



      doc.setFontSize(10);
      doc.text('CITE ',18,17)
      doc.text('CORRESPONDENCIA CREADA ',43,17)
        doc.setFont('times', 'bold');
        doc.setDrawColor(122);
      let numhoja=1
      let cont=0
      doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
      doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
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
       // doc.line(170, 20+i*34, 170, 54+i*34)//line1
        doc.setFontSize(12);
        doc.setFont('times', 'bold');
        doc.text(d.fecha.toString(),23,25+i*34,'center')
        doc.setFont('times', 'normal');
        doc.setFontSize(12);
        doc.text(d.codigo.toString(),23,38+i*34,'center')
        doc.setFontSize(12);
        doc.text(d.citecontrol.toString(),23,43+i*34,'center')


        doc.setFontSize(10);
        // doc.setFont('times', 'bold');
        doc.text('De: '+d.remitente,41,25+i*34,'left')
        doc.text('A: '+d.destinatario,41,30+i*34,'left')
        doc.text('REF: '+d.ref.substr(0,50),41,35+i*34,'left')
        doc.text(d.ref.substr(50,50),41,40+i*34,'left')
        doc.text(d.ref.substr(100,50),41,45+i*34,'left')
        doc.text(d.ref.substr(150,50),41,50+i*34,'left')
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


        //
        //
        // let con=5

        // for (let i=0;i<8;i++){
        //   // doc.roundedRect(8, 52+i*80, 194, 80, 2, 2, 'S')
        //   doc.roundedRect(8, 20+i*34, 194, 34, 0, 0, 'S')
        //
        //   // doc.setFontSize(5)
        //   // doc.text(['ATENDRE TRAMITE DE','A CUERDO','A PROCEDIMIENTO','VIGENTE Y NORMATIVA'],21,22+i*68,{align:'center'})
        //   // doc.setFontSize(9)
        //   // doc.text('RESPONDER',21,34+i*68,{align:'center'})
        //   // doc.text('INFORME',21,43+i*68,{align:'center'})
        //   // doc.text('TOME ACCION',21,51+i*68,{align:'center'})
        //   // doc.text('NOTIFICAR',21,60+i*68,{align:'center'})
        //   // doc.setFontSize(6)
        //   // doc.text(['PROCESAR CONFORME','EL PROVEIDO QUE','ANTECEDE'],21,65+i*68,{align:'center'})
        //   // doc.setFontSize(9)
        //   // doc.text(['PROYECTAR','NOTA'],21,75+i*68,{align:'center'})
        //   // doc.text('ARCHIVAR',21,85+i*68,{align:'center'})
        //   // doc.roundedRect(35, 20+i*68, 5, 8.5, 1, 1, 'S')
        //   // doc.roundedRect(35, 28.5+i*68, 5, 8.5, 1, 1, 'S')
        //   // doc.roundedRect(35, 37+i*68, 5, 8.5, 1, 1, 'S')
        //   // doc.roundedRect(35, 45.5+i*68, 5, 8.5, 1, 1, 'S')
        //   // doc.roundedRect(35, 54+i*68, 5, 8.5, 1, 1, 'S')
        //   // doc.roundedRect(35, 62.5+i*68, 5, 8.5, 1, 1, 'S')
        //   // doc.roundedRect(35, 71+i*68, 5, 8.5, 1, 1, 'S')
        //   // doc.roundedRect(35, 79.5+i*68, 5, 8.5, 1, 1, 'S')
        //   doc.line(40, 20+i*34, 40, 54+i*34)//line1
        //   doc.line(170, 20+i*34, 170, 54+i*34)//line1
        //   // doc.line(8, 37+i*68, 40, 37+i*68)//line2
        //   // doc.line(8, 45.5+i*68, 40, 45.5+i*68)//line3
        //   // doc.line(8, 54+i*68, 40, 54+i*68)//line4
        //   // doc.line(8, 62.5+i*68, 40, 62.5+i*68)//line5
        //   // doc.line(8, 71+i*68, 40, 71+i*68)//line5
        //   // doc.line(8, 79.5+i*68, 40, 79.5+i*68)//line6
        //   //
        //   // doc.text('INSTRUCCIONES:',85,23+i*68,{align:'center'})
        //   // doc.text('_________________',85,23+i*68,{align:'center'})
        //   // doc.text('.................................................................................................................',40,28.5+i*68)
        //   // doc.text('.................................................................................................................',40,33+i*68)
        //   // doc.text('.................................................................................................................',40,37+i*68)
        //   // doc.text('.................................................................................................................',40,41.5+i*68)
        //   // doc.text('.................................................................................................................',40,45.5+i*68)
        //   // doc.text('.................................................................................................................',40,50+i*68)
        //   // doc.text('.................................................................................................................',40,54+i*68)
        //   // doc.text('.................................................................................................................',40,58.5+i*68)
        //   // doc.text('.................................................................................................................',40,62.5+i*68)
        //   // doc.text('.................................................................................................................',40,67+i*68)
        //   // doc.text('.................................................................................................................',40,71+i*68)
        //   // doc.text('.................................................................................................................',40,75.5+i*68)
        //   // doc.text('.................................................................................................................',40,79.5+i*68)
        //   // doc.text('.................................................................................................................',40,84+i*68)
        //   // doc.text('FIRMAR',115,87+i*68)
        //   //
        //   // doc.roundedRect(130, 20+i*68, 72, 68, 1, 1, 'S')
        //   // doc.line(130, 24+i*68, 202, 24+i*68)//line1
        //   // doc.line(130, 84+i*68, 202, 84+i*68)//line2
        //   // doc.text('DESTINATARIO '+con+':',132,23+i*68)
        //   // doc.text('SELLO DE RECEPCION '+con+':',150,83+i*68)
        //   // doc.text('FECHA:',132,87+i*68)
        //   // doc.text('HORA:',172,87+i*68)
        //   // con++
        // }

        // $( '#docpdf' ).attr('src', doc.output('datauristring'));
        // // doc.save("Pago"+date.formatDate(Date.now(),'DD-MM-YYYY')+".pdf");


        window.open(doc.output('bloburl'), '_blank');
      this.$q.loading.hide()
      // })
      // console.log(c)

      // return false
      // this.$axios.post(process.env.API+'/impruta/'+id).then(res=>{
      //   console.log(res.data);
      //   let myWindow = window.open("", "Imprimir", "width=1000,height=1000");
      //   myWindow.document.write(res.data);
      //   myWindow.document.close();
      //   myWindow.focus();
      //   setTimeout(function(){
      //     myWindow.print();
      //     myWindow.close();
      //   },700);
      // })
    },
  }
}
</script>

<style scoped>

</style>
