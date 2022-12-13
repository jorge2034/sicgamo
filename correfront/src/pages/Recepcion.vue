<template>
<q-page class="q-pa-xs">
  <div class="row">
    <div class="col-12">
      <q-form @submit.prevent="guardar">
        <div class="row" style="border: 1px solid rgba(128,128,128,0.50)">
          <div class="col-6 flex flex-center"><q-radio dense v-model="dato.tipo" val="INTERNO" label="INTERNO"/></div>
          <div class="col-6 flex flex-center"><q-radio dense v-model="dato.tipo" val="EXTERNO" label="EXTERNO"/></div>
          <div class="col-sm-2 col-12 q-pa-xs"><q-input style="text-transform: uppercase" dense autofocus label="Referencia" v-model="dato.ref" outlined/></div>
          <div class="col-sm-6 col-12 q-pa-xs">
            <q-input  @keyup="cambio" style="text-transform: uppercase" outlined dense label="remitente" list="browsers" name="myBrowser" v-model="remitente" />
            <datalist id="browsers">
              <option v-for="r in remitentes" :key="r.id">{{r.remitente}}</option>
            </datalist>
          </div>
          <div class="col-sm-2 col-12 q-pa-xs"><q-input style="text-transform: uppercase" dense label="Cargo" v-model="cargo" outlined/></div>
          <div class="col-sm-2 col-12 q-pa-xs"><q-input style="text-transform: uppercase" dense label="Institucion" v-model="institucion" outlined/></div>
          <div class="col-sm-2 col-12 q-pa-xs"><q-input dense label="Fecha de correspondencia" v-model="dato.fecha" type="date" outlined/></div>
          <div class="col-sm-2 col-12 q-pa-xs"><q-select dense label="Fojas" v-model="dato.folio" :options="folios" outlined /></div>
          <div class="col-sm-2 col-12 q-pa-xs"><q-input dense label="Cod externo" v-model="dato.codexterno" outlined /></div>
          <div class="col-sm-2 col-12 q-pa-xs flex flex-center"><q-btn type="submit" color="primary" icon="add_circle" label="Registrar" v-if="dato.id==undefined || dato.id==''"/>
          <q-btn type="submit" color="amber" icon="edit" label="Modificar" v-else /></div>
        </div>
      </q-form>
    </div>
    <div class="col-12">
      <q-table dense title="Correspondencia de unidad" :rows="mails" :columns="columns" :filter="filter"       :rows-per-page-options="[50,100,150,200,0]"
      >
        <template v-slot:top-right>
          <q-input borderless dense debounce="300" v-model="filter" placeholder="Buscar">
            <template v-slot:append>
              <q-icon name="search" />
            </template>
          </q-input>
        </template>
        <template v-slot:body="props">
        <q-tr :props="props">
          <q-td key="codigo" :props="props">
            {{ props.row.codigo }}
          </q-td>
          <q-td key="codexterno" :props="props">
              {{ props.row.codexterno }}
          </q-td>
          <q-td key="codinterno" :props="props">
              {{ props.row.codinterno }}
          </q-td>
          <q-td key="ref" :props="props">
            <q-badge color="info" v-if="props.row.ref!=''" @click="mostrar(props.row.ref)">
              {{ props.row.ref.substring(0,10) }}...
            </q-badge>
          </q-td>
          <q-td key="remitente" :props="props">
              {{ props.row.remitente }}
          </q-td>
          <q-td key="logs" :props="props">
            <ul style="font-size: 0.6em;padding: 0px;margin: 0px;border: 0px;    list-style: none;">
              <li v-for="l in props.row.logs" :key="l.id">de {{l.remitente}} a {{l.destinatario}}</li>
            </ul>
          </q-td>
          <q-td key="dias" :props="props">
            <q-badge :color="props.row.dias==0?'positive':props.row.dias==1?'amber':'negative'">
            {{ props.row.dias }} d
            </q-badge>
          </q-td>
<!--          <q-td key="estado" :props="props">-->
<!--            <q-badge :color="props.row.estado=='EN PROCESO'?'amber':'negative'">-->
<!--              {{ props.row.estado }}-->
<!--            </q-badge>-->
<!--          </q-td>-->
          <q-td key="folio" :props="props">
              {{ props.row.folio }}
          </q-td>
          <q-td key="archivo" :props="props">
            <template v-if="props.row.archivo!=''">
              <q-btn label="Descargar" color="primary" size="xs" type="a" :href="url+'/../imagenes/'+props.row.archivo" target="__blank"/>
            </template>
          </q-td>
          <q-td key="opciones" :props="props">
            <q-btn-group v-if="props.row.estado!='ARCHIVADO' && props.row.estado!='ANULADO'">
              <q-btn dense @click="impresion(props.row.id)" color="primary" label="ImprimirHR" icon="timeline" size="xs" />
              <q-btn dense @click="editar(props)" color="teal" label="Editar" icon="edit" size="xs" />
              <q-btn dense @click="diaglosasignacion=true;mail=props.row;miaccion='';usuario='',dest=[]" color="positive" label="Remitir" icon="code" size="xs" />
              <q-btn dense @click="archivar(props.row)" color="accent" label="Terminar" icon="list" size="xs" />
              <q-btn dense @click="archivo(props.row)" color="amber" label="Subir " icon="upload" size="xs" />
            </q-btn-group>
          </q-td>
        </q-tr>
        </template>
      </q-table>
      <q-dialog v-model="diaglosasignacion">
        <q-card style="width: 700px;min-width: 80vh">
          <q-card-section>
            <div class="text-h6"> <q-icon name="code"/> {{mail.ref}} Remitir</div>
          </q-card-section>
          <q-card-section class="q-pt-none">
            <q-form @submit.prevent="registrarlog">
            <q-input type="textarea" outlined label="Mi acccion" v-model="miaccion" required/>
              <q-select use-input :options="usuarios" label="Seleccionar personal" v-model="usuario" @filter="filterFn" outlined >
                <template v-slot:no-option>
                  <q-item>
                    <q-item-section class="text-grey">
                      Sin resultados
                    </q-item-section>
                  </q-item>
                </template>
              </q-select>
             <q-btn color="secondary" label="Agregar Dest" @click="tabdest"/>
              <table>
                <tbody>
                  <tr v-for="(row,index) in dest" :key="index"><td>{{row.name}}</td></tr>
                </tbody>
              </table>
              <q-btn label="Remitir" color="teal" icon="send" class="full-width" type="submit"/>
            </q-form>
          </q-card-section>
          <q-card-section align="right">
            <q-btn flat label="Cancelar" color="primary" icon="delete" v-close-popup />
          </q-card-section>
        </q-card>
      </q-dialog>
      <q-dialog v-model="dialogarchivo">
        <q-card style="width: 300px;min-width: 40vh">
          <q-card-section>
            <div class="text-h6"> <q-icon name="list"/> {{mail.ref}} Subir archivo</div>
          </q-card-section>
          <q-card-section class="q-pt-none">
              <q-uploader
                class="full-width"
                label="Subir archivo"
                :factory="uploadFile"
                max-files="1"
              />
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
// import $ from 'jquery'
// import { jsPDF } from "jspdf";
import {date} from 'quasar'
export default {
  data(){
    return {
      miaccion:'',
      filter:'',
      usuario:'',
      diaglosasignacion:false,
      dialogarchivo:false,
      url:process.env.API,
      dato:{tipo:'INTERNO',fecha:date.formatDate(Date.now(),'YYYY-MM-DD'),folio:1},
      folios:[],
      usuarios:[],
      usuarios2:[],
      dest:[],
      mails:[],
      mail:{},
      remitentes:[],
      remitentes2:[],
      remitente:'',
      cargo:'',
      institucion:'',
      columns:[
        {field:'codigo',name:'codigo',label:'codigo',align:'right'},
        {field:'codexterno',name:'codexterno',label:'codexterno',align:'right'},
        // {field:'codinterno',name:'codinterno',label:'codinterno',align:'right'},
        {field:'ref',name:'ref',label:'ref',align:'right'},
        {field:'remitente',name:'remitente',label:'remitente',align:'right'},
        // {field:'cargo',name:'cargo',label:'cargo',align:'right'},
        // {field:'institucion',name:'institucion',label:'institucion',align:'right'},
        // {field:'fecha',name:'fecha',label:'fecha',align:'right'},
        {field:'logs',name:'logs',label:'logs',align:'left'},
        {field:'dias',name:'dias',label:'dias',align:'right'},
        // {field:'estado',name:'estado',label:'estado',align:'right'},
        {field:'folio',name:'folio',label:'Fojas',align:'right'},
        {field:'archivo',name:'archivo',label:'archivo',align:'right'},
        {field:'opciones',name:'opciones',label:'opciones',align:'right'},
      ]
    }
  },
  created() {
    this.misdatos()
    for (let i=1;i<=1000;i++){
      this.folios.push(i)
    }
    this.misremitentes()

    this.$axios.post(process.env.API+'/usuarios').then(res=>{
      res.data.forEach(r=>{
        // console.log(r)
        //if (r.tipo=='SECRETARIA'){
          this.usuarios.push({
            id:r.id,
            name:r.name,
            unit_id:r.unit_id,
            label:r.unit.nombre+'-'+r.name
          })
       // }
      })
      this.usuarios2=this.usuarios
    })
  },
  methods:{
    tabdest(){
      let verif=false;
      this.dest.forEach(element => {
        if(element.id==this.usuario.id)
        verif=true;
      });
      if(!verif)
        this.dest.push(this.usuario);
    },
    filterFn (val, update) {
      if (val === '') {
        update(() => {
          this.usuarios = this.usuarios2

          // here you have access to "ref" which
          // is the Vue reference of the QSelect
        })
        return
      }

      update(() => {
        const needle = val.toLowerCase()
        this.usuarios = this.usuarios2.filter(v => v.label.toLowerCase().indexOf(needle) > -1)
      })
    },
    uploadFile(files) {
      this.file_path = files[0]
      const fileData = new FormData()
      fileData.append('imagen', this.file_path)
      fileData.append('mail_id', this.mail.id)
      // console.log(fileData);
      //Replace http://localhost:8000 with your API URL
      this.$q.loading.show()
      const uploadFile = this.$axios.post(process.env.API+'/upload', fileData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      }).then((response) => {
        this.misdatos()
        this.$q.loading.hide()
        // console.log(response.data);
        // this.dato.imagen=response.data;
        this.dialogarchivo=false
        this.$q.notify({
          color: 'green-4',
          textColor: 'white',
          icon: 'cloud_done',
          message: 'Imagen subido correctamente!'
        });
      });
    },
    registrarlog(){
      // console.log({
      //   mail_id:this.mail.id,
      //   user_id2:this.usuario.id,
      //   destinatario:this.usuario.name,
      //   unit_id:this.usuario.unit_id,
      //   accion:this.miaccion
      // })
      // return false
      console.log(this.dest);
      if(this.dest.length==0){
        this.$q.notify({
          message:'Debe seleccionar al menos 1 Dest',
          color:'red',
          icon:'error'
        })
        return false;
      }
      this.$q.loading.show()
      this.$axios.post(process.env.API+'/log',{
        mail_id:this.mail.id,
        list_user:this.dest,
        //user_id2:this.usuario.id,
        //destinatario:this.usuario.name,
        //unit_id:this.usuario.unit_id,
        accion:this.miaccion
      }).then(res=>{
        // console.log(res.data)
        this.misdatos()
        this.$q.loading.hide()
        this.diaglosasignacion=false
        this.$q.notify({
          message:'Renviado correctamente!!',
          color:'green',
          icon:'done'
        })
      }).catch(err=>{
        this.$q.notify({
          message:err.response.data.message,
          color:'red',
          icon:'error'
        })
        this.$q.loading.hide()
      })
    },
    misremitentes(){
      this.$axios.get(process.env.API+'/mail/create').then(res=>{
        // console.log(res.data)
        this.remitentes=res.data
        // this.remitentes2=res.data
      })
    },
    cambio(){
      this.cargo=''
      this.institucion=''
      // console.log(this.remitente)
      this.remitentes.find(r=>{
        if (r.remitente===this.remitente){
          // console.log(r.cargo)
          this.cargo=r.cargo
          this.institucion=r.institucion
          return false
        }else{
          // this.cargo=''
          // this.institucion=''
        }
      })
    },
    // remitir(){},
    mostrar(ref){
      this.$q.dialog({
        title:'Referencia',
        message:ref
      })
    },
    archivar(mail){
      this.$q.dialog({
        title:'Seguro de archivar?',
        message:'Motivo de archivar',
        prompt:{
          model:'',
          type:'text'
        },
        cancel:true,
      }).onOk(data=>{
        // console.log(data)
        this.$q.loading.show()
        this.$axios.post(process.env.API+'/anulado',{mail_id:mail.id,accion:data,estado:'ARCHIVAR'}).then(res=>{
          this.misdatos();
          this.$q.notify({
            message: 'Archivado',
            caption: 'Registro archivado',
            color: 'green',
            icon:'done'
          });
        })
      })
    },
    archivo(mail){
      this.mail=mail
      this.dialogarchivo=true
    },
    dividir(mail){
      this.$q.dialog({
        title:'En cuantos deseas dividir?',
        message:'Cantidad de divicion',
        prompt:{
          model:'',
          type:'number'
        },
        cancel:true,
      }).onOk(data=>{
        // console.log(data)
        this.$q.loading.show()
        this.$axios.post(process.env.API+'/dividir',{cantidad:data,mail_id:mail.id}).then(res=>{
          this.misdatos();
          this.$q.notify({
            message: 'Dividido',
            caption: 'Registro dividido',
            color: 'green',
            icon:'done'
          });
        })
      })
    },
    editar(props){
      // console.log(props.row);
      this.dato=props.row;
      this.remitente=props.row.remitente
      this.cargo=props.row.cargo
      this.institucion=props.row.institucion
    },
    // imprimir(){
    //   let cm=this;
    //   function header(fecha){
    //     // var img = new Image()
    //     // img.src = 'logo.jpg'
    //     // doc.addImage(img, 'jpg', 0.5, 0.5, 2, 2)
    //     doc.setFont(undefined,'bold')
    //     doc.text(5, 1, 'RESUMEN DIARIO DE INGRESOS')
    //     doc.text(5, 1.5, ' '+fecha)
    //     doc.text(1, 3, 'Nº COMPROBANTE')
    //     doc.text(4, 3, 'Nº TRAMITE')
    //     doc.text(7, 3, 'CONTRIBUYENTE')
    //     doc.text(13.5, 3, 'CI/RUN/RUC')
    //     doc.text(16, 3, 'MONTO BS.')
    //     doc.text(18, 3, 'CAJERO')
    //     doc.setFont(undefined,'normal')
    //   }
    //   var doc = new jsPDF('p','cm','letter')
    //   // console.log(dat);
    //   doc.setFont("courier");
    //   doc.setFontSize(9);
    //   // var x=0,y=
    //   header(Date.now())
    //   // let xx=x
    //   // let yy=y
    //   let y=0
    //   // this.pagos.forEach(r=>{
    //   //   // xx+=0.5
    //   //   y+=0.5
    //   //   doc.text(1, y+3, r.nrocomprobante)
    //   //   doc.text(4, y+3, r.nrotramite)
    //   //   doc.text(7, y+3, r.cliente)
    //   //   doc.text(13.5, y+3, r.ci)
    //   //   doc.text(16, y+3, r.total)
    //   //   doc.text(18, y+3, r.cajero )
    //   //   if (y+3>25){
    //   //     doc.addPage();
    //   //     header(this.fecha)
    //   //     y=0
    //   //   }
    //   // })
    //   doc.text(12, y+4, 'TOTAL RECAUDADCION: ')
    //   doc.text(18, y+4, '1000 Bs')
    //   // doc.save("Pago"+date.formatDate(Date.now(),'DD-MM-YYYY')+".pdf");
    //   window.open(doc.output('bloburl'), '_blank');
    // },
    // filterFn (val, update) {
    //   // console.log(val)
    //   if (val === '') {
    //     update(() => {
    //       this.remitentes = this.remitentes2
    //       this.remitente=''
    //       // here you have access to "ref" which
    //       // is the Vue reference of the QSelect
    //     })
    //     return false
    //   }
    //
    //   update(() => {
    //     const needle = val.toLowerCase()
    //     this.remitentes = this.remitentes2.filter(v => v.remitente.toLowerCase().indexOf(needle) > -1)
    //   })
    // },
    misdatos(){
      this.$q.loading.show()
      this.$axios.get(process.env.API+'/mail').then(res=>{
        // console.log(res.data)
        // this.mails=res.data
        this.mails=[]
        res.data.forEach(r=>{
          const date1 = new Date()
          const date2 = date.extractDate(r.fecha, 'YYYY-MM-DD')
          const dias = date.getDateDiff(date1, date2, 'days')

          this.mails.push({
            id:r.id,
            codigo:r.codigo,
            tipo:r.tipo,
            tipo2:r.tipo2,
            ref:r.ref,
            remitente:r.remitente,
            cargo:r.cargo,
            institucion:r.institucion,
            fecha:r.fecha,
            fechacarta:r.fechacarta,
            estado:r.estado,
            folio:r.folio,
            archivo:r.archivo,
            codinterno:r.codinterno,
            codexterno:r.codexterno,
            logs:r.logs,
            dias:dias,
          })
        })
        this.$q.loading.hide()
      })
    },
    anular(mail){
      this.$q.dialog({
        title:'Seguro de anular?',
        message:'Motivo de anular',
        prompt:{
          model:'',
          type:'text'
        },
        cancel:true,
      }).onOk(data=>{
        // console.log(data)
        this.$q.loading.show()
        this.$axios.post(process.env.API+'/anulado',{mail_id:mail.id,accion:data,estado:'ANULADO'}).then(res=>{
          this.misdatos();
          this.$q.notify({
            message: 'Anulado',
            caption: 'Registro anulado',
            color: 'green',
            icon:'done'
          });
        })
      })
    },
    impresion(id){
      this.$axios.post(process.env.API+'/impruta/'+id).then(res=>{
        console.log(res.data);
              let myWindow = window.open("", "Imprimir", "width=200,height=100");
              myWindow.document.write(res.data);
              myWindow.document.close();
              myWindow.focus();
              setTimeout(function(){
                myWindow.print();
                myWindow.close();
              },500);
      })

    },
    guardar(){
      if (!confirm("seguro de continuar?")){
        return false
      }
      // console.log(this.remitente)
      // return false
      this.dato.remitente=this.remitente
      this.dato.cargo=this.cargo
      this.dato.institucion=this.institucion
      if(this.dato.id==undefined || this.dato.id==''){
        // console.log('new')
      this.$q.loading.show()
      this.$axios.post(process.env.API+'/mail',this.dato).then(res=>{
        console.log(res.data)
        this.dato={tipo:'INTERNO',fecha:date.formatDate(Date.now(),'YYYY-MM-DD'),folio:1};
        this.remitente=''
        this.cargo=''
        this.institucion=''
        this.misdatos()
        this.misremitentes()

        // this.$q.loading.hide()
      }).catch(err=>{
        this.$q.loading.hide()
        this.$q.notify({
          message:err.response.data.message,
          color:'red',
          icon:'error'
        })
      })}
      else{
      this.$q.loading.show()
      this.$axios.post(process.env.API+'/updatemail',this.dato).then(res=>{
        this.dato={tipo:'INTERNO',fecha:date.formatDate(Date.now(),'YYYY-MM-DD'),folio:1};
        this.remitente=''
        this.cargo=''
        this.institucion=''
        // console.log(res.data)
        this.misdatos()
        this.misremitentes()

        // this.$q.loading.hide()
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

}
</script>

<style scoped>

</style>
