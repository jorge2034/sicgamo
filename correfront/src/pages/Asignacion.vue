<template>
  <q-page class="q-pa-xs">

    <div class="row">
      <div class="col-12">
<!--        <div class="col-12">-->
<!--          <iframe id="docpdf" src="" frameborder="0" style="width: 100%;height: 100vh"></iframe>-->
<!--        </div>-->
        <q-btn label="Crear" icon="mail" color="primary" @click="fromcrear" />
        <q-btn label="Actualizar" icon="refresh" color="amber-5" @click="actualizar" />
        <q-dialog full-width v-model="crear">
          <q-card>
            <q-card-section>
              <div class="text-h6" v-if="dato.id==undefined">Crear Hoja de ruta</div>
              <div class="text-h6" v-else>Modificar Hoja de ruta</div>
<!--              <pre>{{dato}}</pre>-->
            </q-card-section>
            <q-card-section class="q-pt-none">
              <q-form @submit.prevent="guardar">
                <div class="row" style="border: 1px solid rgba(128,128,128,0.50)">
                  <div class="col-6 flex flex-center"><q-radio dense required v-model="dato.tipo" val="EXTERNO" label="EXTERNO"/></div>
                  <div class="col-6 flex flex-center"><q-radio dense required v-model="dato.tipo" val="INTERNO" label="INTERNO"/></div>
                  <div class="col-sm-2 col-12 q-pa-xs">
                    <q-input
                    style="text-transform: uppercase" required
                    dense
                    label="Cite/Codigo/Tramite"
                    autofocus
                    v-model="dato.citecontrol"
                    outlined
                    bottom-slots
                    hint="Max 10 Carácteres"
                    counter
                    maxlength="12"
                    />
                    </div>
                  <div class="col-sm-2 col-12 q-pa-xs"><q-input style="text-transform: uppercase" required dense label="Cite entrante" autofocus v-model="dato.cite"  outlined /></div>
                  <div class="col-sm-4 col-12 q-pa-xs">
                    <!-- <q-input style="text-transform: uppercase" outlined dense label="Destinatario" v-model="destinatario"/> -->
                     <q-input style="text-transform: uppercase" outlined dense label="Destinatario" list="destinatario" name="midestinatario" v-model="destinatario" />
                    <datalist id="destinatario">
                      <option v-for="r in destinatarios" :key="r.id">{{r.destinatario}}</option>
                    </datalist>
                  </div>
                  <div class="col-sm-4 col-12 q-pa-xs">
                    <q-input  @keyup="cambio" style="text-transform: uppercase" outlined dense label="remitente" list="browsers" name="myBrowser" v-model="remitente" />
                    <datalist id="browsers">
                      <option v-for="r in remitentes" :key="r.id">{{r.remitente}}</option>
                    </datalist>
                  </div>

                  <div class="col-sm-2 col-12 q-pa-xs"><q-input style="text-transform: uppercase" dense label="Cargo" v-model="cargo" outlined/></div>
                  <div class="col-sm-2 col-12 q-pa-xs"><q-input style="text-transform: uppercase" dense label="Institucion" v-model="institucion" outlined/></div>
                  <div class="col-sm-8 col-12 q-pa-xs"><q-input style="text-transform: uppercase" dense  label="Referencia" v-model="dato.ref" outlined/></div>
                  <div class="col-sm-2 col-12 q-pa-xs"><q-input dense label="Fecha de correspondencia" v-model="dato.fecha" type="date" outlined/></div>
                  <div class="col-sm-2 col-12 q-pa-xs"><q-input dense label="Fojas" v-model="dato.folio"  outlined /></div>
                  <div v-if="secretariageneral.includes($store.state.login.user.id)" class="col-sm-2 col-12 q-pa-xs"><q-checkbox v-model="internosg" label="Interno SG" color="teal" /></div>
<!--                  <div class="col-sm-2 col-12 q-pa-xs"><q-input dense label="Cod externo" v-model="dato.codexterno" outlined /></div>-->
                  <div class="col-sm-2 col-12 q-pa-xs flex flex-center">
                    <q-btn type="submit" color="primary" icon="add_circle" label="Registrar" v-if="dato.id==undefined || dato.id==''"/>
                    <q-btn type="submit" color="amber" icon="edit" label="Modificar" v-else />
                  </div>
                </div>
              </q-form>

            </q-card-section>

            <q-card-actions align="right">
              <q-btn flat label="Cerrar" icon="delete" color="primary" v-close-popup />
            </q-card-actions>
          </q-card>
        </q-dialog>

      </div>
      <div class="col-12">
        <q-table
          dense
          title="Correspondencia"
          :rows="mails"
          :columns="columns"
          :filter="filter"
          v-model:pagination="pagination"
          :loading="loading"
          :rows-per-page-options="[10,100,150,200,0]"
           row-key="name"
           @request="handleRequest"
        >
          <template v-slot:top-right>
            <q-input outlined bottom-slots dense debounce="300" v-model="filter" @keyup.enter="buscar" placeholder="Buscar">
              <template v-slot:append>
                <q-icon v-if="filter !== ''" name="close" @click="actualizar" class="cursor-pointer" />
                <q-icon name="search" />
              </template>
            </q-input>
          </template>
          <template v-slot:body-cell-documento="props">
              <q-td key="ref" :props="props"  @click="mostrar(props.row)">
                  {{ props.row.ref.substring(0,20) }} <q-icon name="visibility" color="info"/>
              </q-td>
          </template>
          <!-- opciones de impresion solo para secretaria general -->
          <template v-if="secretariageneral.includes($store.state.login.user.id)" v-slot:body-cell-logs="props">
              <q-td key="logs" :props="props">
                <ul style="font-size: 0.8em;padding: 0px;margin: 0px;border: 0px;    list-style: none;">
                  <li v-for="l in props.row.logs" :key="l.id">

                    <q-btn @click="impresioncondependenciassecretariageneral(l)" v-if="l.estado=='EN PROCESO'"  size="xs" icon="print" color="info" flat round/>
                    <!-- uso exclusivo para secretaria del alcalde despacho UNIT_ID=97 -->
                    <q-btn @click="impresioncondependenciassecretariageneral(l)" v-if="l.estado=='ACEPTADO' &&  secretarios.includes($store.state.login.user.id)" size="xs" icon="print" color="info" flat round/>

                    <q-badge v-if="props.row.id==l.id" color="blue-grey" :label="'->'+l.unit.nombre"> </q-badge>
                    <template v-else>{{l.unit.nombre}}</template>

                    <q-badge v-if="l.estado=='REMITIDO'" color="positive" :label="l.estado" />
                    <q-badge v-if="l.estado=='ACEPTADO'" color="info" :label="l.estado" />
                    <q-badge v-if="l.estado=='EN PROCESO'" color="negative" :label="l.estado" />
                    <q-badge v-if="l.estado=='ARCHIVADO'" color="amber-14" :label="l.estado" />
                  </li>
                </ul>
                <div v-if="props.row.estado=='EN PROCESO' || props.row.estado=='ACEPTADO'">
                <q-badge v-if="props.row.accion!=''" color="warning" :label="'Recibido de: '+props.row.user1"> </q-badge><br>
                </div>

                <q-btn color="positive" dense icon="add_circle_outline" label="REMITIR" @click="dialogremitir=true;mail=props.row; dest=[]" />
                <q-btn @click="impresionextra(props.row)" v-if="props.row.estado!='ARCHIVADO'" class="q-px-lg" size="xs" label="Hoja de Ruta extra" icon="print" color="green-10" flat round/>
              </q-td>
          </template>
          <template v-else v-slot:body-cell-logs="props">
              <q-td key="logs" :props="props">

                <ul style="font-size: 0.8em;padding: 0px;margin: 0px;border: 0px;    list-style: none;">
                  <li v-for="l in props.row.logs" :key="l.id">

                    <q-badge v-if="props.row.id==l.id" class="q-px-none q-mx-none" color="blue-grey" :label="'->'+l.unit.nombre"> </q-badge>
                    <template v-else>{{l.unit.nombre}}</template>
                    <!-- <q-badge :color="l.estado=='REMITIDO'||l.estado=='ARCHIVADO'?'positive':'negative'" :label="l.estado" /> -->
                    <q-badge v-if="l.estado=='REMITIDO'" color="positive" :label="l.estado" />
                    <q-badge v-if="l.estado=='ACEPTADO'" color="info" :label="l.estado" />
                    <q-badge v-if="l.estado=='EN PROCESO'" color="negative" :label="l.estado" />
                    <q-badge v-if="l.estado=='ARCHIVADO'" color="amber-14" :label="l.estado" />
                  </li>
                </ul>

                <q-btn @click="impresioncondependencias(props.row)" v-if="props.row.estado=='REMITIDO'" label="Hoja de Ruta" size="xs" icon="print" color="info" flat round/>
                    <!-- uso exclusivo para secretaria del alcalde despacho UNIT_ID=97 -->
                <q-btn @click="impresioncondependencias(props.row)" v-if="props.row.estado=='ACEPTADO' &&  secretarios.includes($store.state.login.user.id)" size="xs" label="Hoja de Ruta" icon="print" color="info" flat round/>
                <q-btn @click="impresionextra(props.row)" class="q-px-lg" v-if="props.row.estado!='ARCHIVADO'" label="Hoja de Ruta extra" size="xs" icon="print" color="green-10" flat round/>

                <div v-if="props.row.estado=='EN PROCESO' || props.row.estado=='ACEPTADO'">
                <q-badge v-if="props.row.accion!=''" color="warning" :label="'Recibido de: '+props.row.user1"> </q-badge><br>
                </div>
              </q-td>
          </template>
<!--          <template v-slot:body-cell-dias="props">-->
<!--              <q-td key="dias" :props="props">-->
<!--                <q-badge :color="props.row.dias==0?'positive':props.row.dias==1?'amber':'negative'">-->
<!--                  {{ props.row.dias }} d-->
<!--                </q-badge>-->
<!--              </q-td>-->
<!--          </template>-->
          <template v-slot:body-cell-fecha="props">
              <q-td  :props="props">
                <div class="text-h6"> {{props.row.fecha}}<br>{{props.row.hora}}</div>
              </q-td>
          </template>
          <template v-slot:body-cell-codigo="props">
              <q-td  :props="props">
              <strong> {{props.row.codigo}}</strong><br>
                CITE: {{props.row.citecontrol}}

              </q-td>
          </template>





          <template v-slot:body-cell-dias="props">
              <q-td  :props="props">
               <q-tooltip class="bg-amber text-black shadow-4" anchor="top middle" self="top middle">
                    {{props.row.fecha}}
              </q-tooltip>
               {{props.row.dias}}
              </q-td>
          </template>

          <template v-slot:body-cell-archivo="props">
              <q-td key="archivo" :props="props">
                <template v-if="props.row.archivo!=''">
                  <q-btn label="Descargar" color="primary" size="xs" type="a" :href="url+'/../imagenes/'+props.row.archivo" target="__blank"/>
                </template>
              </q-td>
          </template>
          <template  v-slot:body-cell-opciones="props">
              <q-td auto-width key="opciones" :props="props">
<!--                <q-btn-group>-->
                  <template v-if="props.row.estado=='EN PROCESO'">
                    <q-btn dense @click="aceptar(props.row)" color="info" label="Aceptar" icon="code" size="xs" />
                  </template >
                  <template v-if="props.row.estado=='ARCHIVADO'">
                  <q-badge color="amber-9">
                    Archivado
                  </q-badge><br>
                    <q-btn @click="desarchivar(props.row)" color="blue-grey-6" label="Desarchivar" icon="settings_backup_restore" size="sm">
                    </q-btn>
                  </template >
                <template v-if="props.row.estado=='REMITIDO'">
                  <small v-if="props.row.nopuedecancelarremision" style="color: darkgreen;font-weight: bold">Remitido</small>

                    <q-btn v-else @click="cancelarremision(props.row)" color="light-blue-9" label="Cancelar remisión" icon="cancel" size="xs">
                     <q-tooltip anchor="top middle" self="bottom middle" :offset="[5, 5]">
                      Se podra cancelar hasta que el destinatario acepte la correspondencia
                    </q-tooltip>
                    </q-btn>
                    <!-- <q-btn dense color="info" label="" icon="help" size="xs">
                      <q-tooltip class="bg-amber text-black shadow-4" anchor="top right" self="top middle">
                         Puede cancelar antes que el destinatario acepte la correspondencia
                      </q-tooltip>
                    </q-btn> -->
                </template >
                  <template v-if="props.row.estado=='ACEPTADO'">
                    <q-btn-dropdown color="primary" label="Opciones">
                      <q-list>
                        <q-item v-if="$store.state.login.user.id===props.row.user_id" clickable v-close-popup @click="modificar(props.row)">
                          <q-item-section>
                            <q-item-label>Modificar Correspodencia</q-item-label>
                          </q-item-section>
                        </q-item>

                        <q-item clickable v-close-popup @click="dialogremitir=true;mail=props.row; dest=[]">
                          <q-item-section>
                            <q-item-label>Remitir correspodencia</q-item-label>
                          </q-item-section>
                        </q-item>
<!--                        <q-item clickable v-close-popup @click="impresion(props.row)">-->
<!--                          <q-item-section>-->
<!--                            <q-item-label>Imprimir HR</q-item-label>-->
<!--                          </q-item-section>-->
<!--                        </q-item>-->
                        <!-- <q-item clickable v-close-popup @click="archivo(props.row)">
                          <q-item-section>
                            <q-item-label>Subir Archivo</q-item-label>
                          </q-item-section>
                        </q-item> -->
                        <q-item clickable v-close-popup @click="archivar(props.row)">
                          <q-item-section>
                            <q-item-label>Archivar</q-item-label>
                          </q-item-section>
                        </q-item>
                      </q-list>
                    </q-btn-dropdown>
<!--                    <q-btn dense @click="modificar(props.row)" color="warning" label="Modifica Correspondencia" icon="edit" size="xs" /><br>-->
<!--                    <q-btn dense @click="diaglosasignacion=true;mail=props.row; dest=[]" color="positive" label="Remitir Correspodencia" icon="code" size="xs" /><br>-->
<!--                    <q-btn dense @click="impresion(props.row.mail_id)" color="info" label="Imprimir Hoja Ruta" icon="picture_as_pdf" size="xs" /><br>-->
<!--&lt;!&ndash;                    <q-btn dense @click="impresion2(props.row.mail_id)" color="info" label="IMP" icon="print" size="xs" /><br>&ndash;&gt;-->
<!--                    <q-btn dense @click="archivo(props.row)" color="amber" label="Subir Archivo a nube" icon="upload" size="xs" /><br>-->
<!--                    <q-btn dense @click="archivar(props.row)" color="negative" label="Archivar Correspondencia" icon="list" size="xs" /><br>-->
                  </template>
<!--                </q-btn-group>-->
              </q-td>
          </template>
        </q-table>
        <q-dialog full-width full-height v-model="diaglosasignacion">
          <q-card >
            <q-card-section>
              <div class="text-h6"> <q-icon name="outgoing_mail"/> {{mail.ref}} | Remitir</div>
            </q-card-section>
            <q-card-section class="q-pt-none">
              <q-form @submit.prevent="registrarlog">
                <q-input type="textarea" style="text-transform: uppercase" outlined label="Instruccion / Observacion" v-model="miaccion" required/>
<!--                <q-select :options="usuarios" label="Seleccionar personal" v-model="usuario" outlined required/>-->
                <q-select dense use-input :options="usuarios" label="Seleccionar personal" v-model="usuario" @filter="filterFn" outlined >
                  <template v-slot:no-option>
                    <q-item>
                      <q-item-section class="text-grey">
                        Sin resultados
                      </q-item-section>
                    </q-item>
                  </template>
                </q-select>
                <q-btn color="positive"  label="Agregar Destinatario" icon="add_circle" @click="tabdest"/>
<!--                <table>-->
<!--                  <tbody>-->
<!--                  <tr v-for="(row,index) in dest" :key="index"><td>{{index+1}}- {{row.label}} </td></tr>-->
<!--                  </tbody>-->
<!--                </table>-->
                <q-list dense bordered padding class="rounded-borders">
                  <q-item clickable v-ripple v-for="(row,index) in dest" :key="index">
                    <q-item-section class="q-pa-none text-subtitle2" >
                      {{index+1}} {{row.name}}
<!--                      <pre>{{row}}</pre>-->
                    </q-item-section >
                    <q-item-section class="q-pa-none text-subtitle2">
                      {{row.unit.nombre}}
                    </q-item-section>
                    <q-item-section class="q-pa-none text-subtitle2">
                      <q-btn @click="quitardestinatario(index)" icon="delete" color="negative" flat />
                    </q-item-section>
                  </q-item>
                </q-list>
<!--                {{mail}}-->
                <q-btn label="Remitir" color="teal" icon="send" class="full-width" type="submit"/>
              </q-form>
            </q-card-section>
            <q-card-section align="right">
              <q-btn flat label="Cancelar" color="primary" icon="delete" v-close-popup />

            </q-card-section>
          </q-card>
        </q-dialog>

        <q-dialog v-model="dialogayudaremitir" full-width full-height>
          <q-card>
            <q-card-section>
              <div class="text-h6"> <q-icon name="help"/> ¿Como Remitir?</div>
            </q-card-section>
            <q-card-section class="q-pt-none">
              <q-img
                src="img/ayudaremtir.gif"
                spinner-color="white"
                style="height:50%; width: 90%"
              />
            </q-card-section>
            <q-card-section align="right">
              <q-btn flat label="Cancelar" color="primary" icon="delete" v-close-popup />
            </q-card-section>
          </q-card>
        </q-dialog>



        <q-dialog full-width full-height v-model="dialogremitir">
          <q-card >
            <q-card-section>
              <div class="text-h6"> <q-icon name="outgoing_mail"/> {{mail.ref}} | Remitir</div>
            </q-card-section>
            <q-card-section class="q-pt-none">
              <q-form @submit.prevent="registrarlog">
<!--                <q-select :options="usuarios" label="Seleccionar personal" v-model="usuario" outlined required/>-->
                  <div class="row">
                        <div class="col-8">
                          <q-select class="col-8" dense use-input :options="usuarios" label="Seleccionar personal" v-model="usuario" @filter="filterFn" outlined>
                            <template v-slot:no-option>
                              <q-item>
                                <q-item-section class="text-grey">
                                  Sin resultados
                                </q-item-section>
                              </q-item>
                            </template>
                            <template v-slot:append>
                              <q-icon name="close" @click.stop.prevent="usuario = ''" class="cursor-pointer" />
                            </template>
                          </q-select>
                        </div>
                        <div class="col">
                          <q-btn  class="col" color="positive"  label="Agregar Destinatario" icon="add_circle" @click="tabdest" />
                          <q-btn color="info"  label="Ayuda" icon="help" @click="dialogayudaremitir=true"/>

                        </div>
                      </div>


<!--                <table>-->
<!--                  <tbody>-->
<!--                  <tr v-for="(row,index) in dest" :key="index"><td>{{index+1}}- {{row.label}} </td></tr>-->
<!--                  </tbody>-->
<!--                </table>-->
                <q-list dense bordered padding class="rounded-borders">
                  <q-item clickable v-ripple v-for="(row,index) in dest" :key="index">
                    <q-item-section class="top" no-wrap>
                          <q-item-label lines="1" >
                            <span class="text-weight-medium"> {{index+1}} {{row.listuser.name}}</span>
                          </q-item-label>
                          <q-item-label lines="1" class="q-mt-xs text-weight-bold text-primary text-uppercase">
                            <span class="text-grey-8 cursor-pointer">{{row.listuser.unit.nombre}}</span>
                          </q-item-label>
                    </q-item-section >
                    <q-item-section class="q-pa-none text-subtitle2">
                          <q-input
                          dense
                          style="text-transform: uppercase"
                            v-model="row.instruccion"
                            filled
                            clearable
                            autogrow
                            label="INSTRUCCION / PROVEIDO"
                            required
                          />
                    </q-item-section>
                    <q-item-section >
                        <div class="text-grey-8" style="max-width: 200px">
                          <q-select outlined v-model="row.tipodoc" label="Tipo documento" hint="OPCIONAL" :options="optionstipodocs" style="max-width: 200px" dense options-dense>
                            <template v-slot:prepend>
                              <q-icon name="note_add" />
                            </template>
                          </q-select>

                          </div>
                    </q-item-section>
                    <q-item-section>
                          <q-input
                          dense
                          style="text-transform: uppercase"
                            v-model="row.observacion"
                            filled
                            clearable
                            autogrow
                            label="OBSERVACIÓN EXTRA"
                          />
                    </q-item-section>
                    <q-item-section style="max-width: 150px">
                        <div class="text-grey-8 q-gutter-xs">

                           <q-input
                          dense
                          outlined
                          v-model="row.nfojas"
                          label="N° Fojas"
                          hint="OPCIONAL"

                        />
                          </div>
                    </q-item-section>
                     <q-item-section style="max-width: 100px" >
                          <div class="text-grey-8 q-gutter-xs">
                            <q-btn @click="quitardestinatario(index)" icon="delete" color="negative" flat />
                          </div>
                        </q-item-section>
                  </q-item>
                </q-list>
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
import { jsPDF } from "jspdf";
import { format, render, cancel, register } from 'timeago.js';
import $ from 'jquery'
import {date} from 'quasar'
export default {
  props:{
    tipoasignacion:{
      type: String
    }
  },
  data(){
    return {
      destinatario:'',
      destinatarios:'',
      crear:false,
      miaccion:'',
      filter:'',
      usuario:'',
      diaglosasignacion:false,
      dialogremitir:false,
      dialogarchivo:false,
      url:process.env.API,
      dato:{tipo:'',fecha:date.formatDate(Date.now(),'YYYY-MM-DD'),folio:1},
      //folios:[],
      usuarios:[],
      usuarios2:[],
      mails:[],
      mail:{},
      // log:{},
      remitentes:[],
      remitentes2:[],
      remitente:'',
      cargo:'',
      institucion:'',
      codigo:'',
      dest:[],
      contadorcreadosignorados:0,
      secretarios:[172,292,678,673,671,121,672,169,106,42,677,217,679],
      secretariageneral:[172,32],
      optionstipodocs:['Notas','Memorandum','Hoja de ruta'],
      tipodoc:null,
      derivaciones: [],
      dialogayudaremitir:false,
      internosg:false,
      columns:[
        {name:'opciones',field:'opciones',label:'opciones',align:'right'},
        {name:'codigo',field:'codigo',label:'codigo/CITE',align:'left'},
        {name:'logs',field:'logs',label:'HISTORIAL',align:'left'},
        {name:'documento',field:'documento',label:'Documento',align:'left'},
        // {name:'fecha',field:'fecha',label:'fecha',align:'right'},
        // {name:'hora',field:'hora',label:'hora',align:'right'},
        // {field:'codinterno',name:'codinterno',label:'codinterno',align:'right'},
        // {name:'ref',field:'ref',label:'ref',align:'right'},
        // {field:'cargo',name:'cargo',label:'cargo',align:'right'},
        // {field:'institucion',name:'institucion',label:'institucion',align:'right'},
         //{field:'fecha',name:'fecha',label:'fecha',align:'right'},
        // {name:'logs',field:row=>'logs',label:'logs',align:'left'},
        {name:'dias',field:'dias',label:'dias',align:'right'},
        // {field:'estado',name:'estado',label:'estado',align:'right'},
        // {name:'folio',field:'folio',label:'Fojas',align:'right'},
        // {name:'archivo',field:'archivo',label:'archivo',align:'right'},

      ],
      pagination:{
        // sortBy: 'name',
      // descending: false,
        page:1,
        rowsPerPage: 3,
        rowsNumber: 0
      },
      loading:false,
    }
  },
  computed:{
  },
  mounted() {

  },
  created() {

    this.misdatos()
    // for (let i=1;i<=1000;i++){
    //   this.folios.push(i)
    // }
    this.misremitentes()
    this.misdestinatarios()
    this.$axios.post(process.env.API+'/misremetentes').then(res=>{
      res.data.forEach(r=>{
        // console.log(r)
        r.label=r.unit.nombre+'-'+r.name
        this.usuarios.push(r)
      })
      this.usuarios2=this.usuarios
    })
    console.log("tipo de asignacion: ",this.tipoasignacion)
  },
  methods:{
    fromcrear(){
      this.crear = true;
      this.dato={tipo:'',fecha:date.formatDate(Date.now(),'YYYY-MM-DD'),folio:1}
      this.remitente=''
      this.cargo=''
      this.institucion=''
      this.codigo=''
    },
    modificar(prop){
      console.log(prop)
      this.crear=true;
      this.dato=prop;
      this.remitente=this.dato.remitente
      this.destinatario=this.dato.destinatario
      this.cargo=this.dato.cargo;
      this.institucion=this.dato.institucion;
      this.codigo=this.dato.codigo
    },
    quitardestinatario(i){
      this.dest.splice(i,1)
    },
    tabdest(){
      let verif=false;
      this.dest.forEach(element => {
        if(element.listuser.id==this.usuario.id)
          verif=true;
      });
      if(!verif && this.usuario!='')
        this.dest.push({
          listuser:this.usuario,
          instruccion: '',
          tipodoc:'',
          nfojas:'',
          observacion:''
          });
          console.log(this.dest)
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
      const data = new FormData()
      data.append('imagen', this.file_path)
      data.append('mail_id', this.mail.mail_id)
      //Replace http://localhost:8000 with your API URL
      this.$q.loading.show()
      this.$axios.post(process.env.API+'/upload', data).then((response) => {
        this.misdatos(this.pagination.page,this.filter,this.pagination.rowsPerPage)
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
      // console.log(this.dest);
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
        log_id:this.mail.id,
        datos:this.dest,
        // list_user:this.dest.listuser,
        // instruccion: this.dest.instruccion,
        // tipodoc:this.dest.tipodoc,
        // nfojas:this.dest.nfojas,
        //user_id2:this.usuario.id,
        //destinatario:this.usuario.name,
        //unit_id:this.usuario.unit_id,
        accion:this.miaccion
      }).then(res=>{
        // console.log(res.data)
        this.filter=''
        this.misdatos()
        // this.$q.loading.hide()
        this.diaglosasignacion=false
        this.dialogremitir=false
        this.$q.notify({
          message:'Remitido correctamente!!',
          color:'green',
          icon:'done'
        })
        this.miaccion=''
        this.dest=[]
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
    misdestinatarios(){
      this.$axios.get(process.env.API+'/destinatarios').then(res=>{
        console.log("destinatarios: ",res.data)
        this.destinatarios=res.data
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
    aceptar(mail){
      // console.log(mail)
      // return false
      this.$q.dialog({
        title:'Seguro de Aceptar?',
        message:'Seguro de aceptar',
        // prompt:{
        //   model:'',
        //   type:'text'
        // },
        cancel:true,
      }).onOk(()=>{
        // console.log(data)
       // this.$q.loading.show()
       this.loading=true
        this.$axios.post(process.env.API+'/aceptar',{mail_id:mail.id}).then(res=>{
          this.misdatos(this.pagination.page,this.filter,this.pagination.rowsPerPage)
          this.$q.notify({
            message: 'Aceptado',
            caption: 'Registro aceptado',
            color: 'green',
            icon:'done'
          });
        })
      })
    },
    mostrar(row){

      this.$q.dialog({
        title:`CODIGO: ${row.codigo}`,
        message:`
          CITE: ${row.cite} <br>
          Fecha creación: ${row.fecha} <br>
          Tipo: ${row.tipo} <br>
          <blockquote>
          Remitente: ${row.remitente} <br>
          Cargo: ${row.cargo} <br>
          Institucion: ${row.institucion} <br>
          </blockquote>
          <strong>Ref: ${row.ref} <br> </strong>
          Fojas: ${row.folio} <br>
          Destinatario: ${row.destinatario} <br>
          Proveido: ${row.estado=='ARCHIVADO'?row.archivadodoc:row.acciondoc} <br>
        `,
        html:true
      })
    },
    impresion(l){
      // console.log(l)
      this.$q.loading.show()
      this.$axios.get(process.env.API+'/mail/'+l.mail_id).then(res=>{
        // console.log(res.data)
        let m=res.data
        this.$q.loading.hide()
        var doc = new jsPDF()
        // doc.setFont("arial");

        // doc.setFont('Arial');
        // var img = new Image()
        // img.src = 'logo.jpg'
        // doc.addImage(img, 'jpg', 190, 3, 70, 20)
        let x=0
        let y=0
        //INICIO CABEZERA
        doc.setDrawColor(122);
        doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
        doc.roundedRect(8, 22, 194, 30, 2, 2, 'S')//destinatario 1
        doc.roundedRect(58, 22, 20, 30, 2, 2, 'S')//el logo HR
        doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
        doc.setFillColor(158,158,158)
        doc.line(8, 28, 58, 28)//line n
        doc.line(8, 36, 58, 36)//line fecha recepcion
        doc.line(8, 46, 58, 46)//line hora repeccion
        doc.line(78, 26, 202, 26)//line remitente
        doc.line(78, 31, 202, 31)//line entidad
        doc.line(78, 36, 202, 36)//line CITE
        doc.line(78, 41, 202, 41)//line referecnia
        doc.line(78, 46, 202, 46)//line hojas
        doc.roundedRect(70, 5, 70, 10, 2, 2, 'F') // fondo gamo
        doc.setFontSize(35);
        doc.setFont('times', 'bold');
        doc.setTextColor(255,255,255)
        doc.text('GAMO',85,14)
        doc.setTextColor(0,0,0)
        doc.setFontSize(37);
        doc.text('HR',58,38)
        doc.setFontSize(7);
        doc.text('HOJA DE RUTA',59,42)
        doc.text(m.tipo.toString(),59,46)
        doc.setTextColor(158,158,158)
        doc.setFontSize(10);
        doc.text('HOJA 1',187,14)
        doc.setFontSize(7);
        doc.text('HOJA DE RUTA',184,17)
        doc.setTextColor(0,0,0)
        doc.setFontSize(11)
        doc.text('REGISTRO DE CORRESPONDENCIA - HOJA DE RUTA',58,20)
        doc.setFontSize(15)
        doc.text('Nº',10,27)
        doc.setFont(undefined, 'normal');
        doc.text(m.codigo.toString(),40,27,'center')
        doc.setFont('times', 'bold');
        doc.setFontSize(10)
        doc.text(['FECHA DE','CREACIÓN:'],10,31)
        doc.setFont(undefined, 'normal');
        doc.text(l.fecha.toString(),45,33,'center')
        doc.setFont('times', 'bold');
        doc.text(['HORA DE','CREACIÓN:'],10,40)
        doc.setFont(undefined, 'normal');
        doc.text(l.hora.toString(),45,42,'center')
        doc.setFont('times', 'bold');
        doc.text('CITE:',10,49)
        doc.setFont('times', 'normal');
        doc.setFontSize(14)
        doc.text(m.citecontrol.toString(),45,50,'center')
        doc.setFontSize(10)
        doc.setFont('times', 'bold');
        doc.text('REMITENTE:',80,25)
        doc.setFont('times', 'normal');
        doc.text(m.remitente,152,25,'center')
        doc.setFont('times', 'bold');
        doc.text('ENTIDAD:',80,30)
        doc.setFont('times', 'normal');
        doc.text(m.institucion,152,30,'center')
        doc.setFont('times', 'bold');
        doc.text('CITE:',80,35)
        doc.setFont('times', 'normal');
        doc.setFontSize(8)
        doc.text(m.cite,120,35,'center')
        doc.setFontSize(10)
        doc.setFont('times', 'bold');
        doc.text('HOJAS:',160,35)
        doc.setFont('times', 'normal');
        doc.text(m.folio,188,35,'center')
        doc.setFont('times', 'bold');
        doc.text('REF:',80,40)
        doc.setFont('times', 'normal');
        doc.text([m.ref.substring(0,50),m.ref.substring(50,100)],148,40,'center')
        doc.setFont('times', 'bold');
        doc.text('DESTINATARIO 1:',80,50)
        doc.setFont(undefined, 'normal');
        doc.text(l.user2.name,152,50,'center')
        doc.setFont('times', 'bold');
        //FIN CABEZERA
        //INICIO CORRESPONDENCIA
        let con=2
        for (let i=0;i<3;i++){
          doc.roundedRect(8, 52+i*80, 194, 80, 2, 2, 'S')

          doc.setFontSize(6)
          doc.text(['ATENDRE TRAMITE DE','A CUERDO','A PROCEDIMIENTO','VIGENTE Y NORMATIVA'],21,54+i*80,{align:'center'})
          doc.setFontSize(10)
          doc.text('RESPONDER',21,69+i*80,{align:'center'})
          doc.text('INFORME',21,79+i*80,{align:'center'})
          doc.text('TOME ACCION',21,89+i*80,{align:'center'})
          doc.text('NOTIFICAR',21,99+i*80,{align:'center'})
          doc.setFontSize(6)
          doc.text(['PROCESAR CONFORME','EL PROVEIDO QUE','ANTECEDE'],21,106+i*80,{align:'center'})
          doc.setFontSize(9)
          doc.text(['PROYECTAR','NOTA'],21,117+i*80,{align:'center'})
          doc.text('ARCHIVAR',21,129+i*80,{align:'center'})
          doc.roundedRect(35, 52+i*80, 5, 10, 1, 1, 'S')
          doc.line(8, 62+i*80, 40, 62+i*80)//line1
          doc.roundedRect(35, 62+i*80, 5, 10, 1, 1, 'S')
          doc.line(8, 72+i*80, 40, 72+i*80)//line2
          doc.roundedRect(35, 72+i*80, 5, 10, 1, 1, 'S')
          doc.line(8, 82+i*80, 40, 82+i*80)//line3
          doc.roundedRect(35, 82+i*80, 5, 10, 1, 1, 'S')
          doc.line(8, 92+i*80, 40, 92+i*80)//line4
          doc.roundedRect(35, 92+i*80, 5, 10, 1, 1, 'S')
          doc.line(8, 102+i*80, 40, 102+i*80)//line5
          doc.roundedRect(35, 102+i*80, 5, 10, 1, 1, 'S')
          doc.line(8, 112+i*80, 40, 112+i*80)//line5
          doc.roundedRect(35, 112+i*80, 5, 10, 1, 1, 'S')
          doc.line(8, 122+i*80, 40, 122+i*80)//line6
          doc.roundedRect(35, 122+i*80, 5, 10, 1, 1, 'S')

          doc.text('INSTRUCCIONES:',85,55+i*80,{align:'center'})
          doc.text('_________________',85,55+i*80,{align:'center'})
          if (i==0){

            if(l.accion.toString()==='CREADO'){
              doc.text(' ',41,61+i*80)
            }
            else
            {
              doc.text(l.accion.toString().substring(0,45),41,61+i*80)
              doc.text(l.accion.toString().substring(45,90),41,66+i*80)
              doc.text(l.accion.toString().substring(90,135),41,71+i*80)
              doc.text(l.accion.toString().substring(135,180),41,76+i*80)
              doc.text(l.accion.toString().substring(180,225),41,81+i*80)
              doc.text(l.accion.toString().substring(225,270),41,86+i*80)
              doc.text(l.accion.toString().substring(270,315),41,91+i*80)
            }
            doc.setFont(undefined, 'bold');
          }


          doc.text('.................................................................................................................',40,62+i*80)
          doc.text('.................................................................................................................',40,67+i*80)
          doc.text('.................................................................................................................',40,72+i*80)
          doc.text('.................................................................................................................',40,77+i*80)
          doc.text('.................................................................................................................',40,82+i*80)
          doc.text('.................................................................................................................',40,87+i*80)
          doc.text('.................................................................................................................',40,92+i*80)
          doc.text('.................................................................................................................',40,97+i*80)
          doc.text('.................................................................................................................',40,102+i*80)
          doc.text('.................................................................................................................',40,107+i*80)
          doc.text('.................................................................................................................',40,112+i*80)
          doc.text('.................................................................................................................',40,117+i*80)
          doc.text('.................................................................................................................',40,122+i*80)
          doc.text('.................................................................................................................',40,127+i*80)
          doc.text('FIRMAR',115,130+i*80)

          doc.roundedRect(130, 52+i*80, 72, 80, 1, 1, 'S')
          doc.line(130, 59+i*80, 202, 59+i*80)//line1
          doc.line(130, 126+i*80, 202, 126+i*80)//line2
          doc.text('DESTINATARIO '+con+':',132,57+i*80)
          doc.text('SELLO DE RECEPCION '+con+':',150,125+i*80)
          doc.text('FECHA:',132,130+i*80)
          doc.text('HORA:',172,130+i*80)
          con++
        }




/////////////////////////////////////
        // doc.addPage();
        // doc.setFont('times', 'bold');
        // doc.setDrawColor(122);
        // doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
        // doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
        // doc.setTextColor(158,158,158)
        // doc.setFontSize(10);
        // doc.text('HOJA 2',187,14)
        // doc.setFontSize(7);
        // doc.text('HOJA DE RUTA',184,17)
        // doc.setTextColor(0,0,0)


        // con=5

        // for (let i=0;i<4;i++){
        //   // doc.roundedRect(8, 52+i*80, 194, 80, 2, 2, 'S')
        //   doc.roundedRect(8, 20+i*68, 194, 68, 2, 2, 'S')

        //   doc.setFontSize(5)
        //   doc.text(['ATENDRE TRAMITE DE','A CUERDO','A PROCEDIMIENTO','VIGENTE Y NORMATIVA'],21,22+i*68,{align:'center'})
        //   doc.setFontSize(9)
        //   doc.text('RESPONDER',21,34+i*68,{align:'center'})
        //   doc.text('INFORME',21,43+i*68,{align:'center'})
        //   doc.text('TOME ACCION',21,51+i*68,{align:'center'})
        //   doc.text('NOTIFICAR',21,60+i*68,{align:'center'})
        //   doc.setFontSize(6)
        //   doc.text(['PROCESAR CONFORME','EL PROVEIDO QUE','ANTECEDE'],21,65+i*68,{align:'center'})
        //   doc.setFontSize(9)
        //   doc.text(['PROYECTAR','NOTA'],21,75+i*68,{align:'center'})
        //   doc.text('ARCHIVAR',21,85+i*68,{align:'center'})
        //   doc.roundedRect(35, 20+i*68, 5, 8.5, 1, 1, 'S')
        //   doc.roundedRect(35, 28.5+i*68, 5, 8.5, 1, 1, 'S')
        //   doc.roundedRect(35, 37+i*68, 5, 8.5, 1, 1, 'S')
        //   doc.roundedRect(35, 45.5+i*68, 5, 8.5, 1, 1, 'S')
        //   doc.roundedRect(35, 54+i*68, 5, 8.5, 1, 1, 'S')
        //   doc.roundedRect(35, 62.5+i*68, 5, 8.5, 1, 1, 'S')
        //   doc.roundedRect(35, 71+i*68, 5, 8.5, 1, 1, 'S')
        //   doc.roundedRect(35, 79.5+i*68, 5, 8.5, 1, 1, 'S')
        //   doc.line(8, 28.5+i*68, 40, 28.5+i*68)//line1
        //   doc.line(8, 37+i*68, 40, 37+i*68)//line2
        //   doc.line(8, 45.5+i*68, 40, 45.5+i*68)//line3
        //   doc.line(8, 54+i*68, 40, 54+i*68)//line4
        //   doc.line(8, 62.5+i*68, 40, 62.5+i*68)//line5
        //   doc.line(8, 71+i*68, 40, 71+i*68)//line5
        //   doc.line(8, 79.5+i*68, 40, 79.5+i*68)//line6

        //   doc.text('INSTRUCCIONES:',85,23+i*68,{align:'center'})
        //   doc.text('_________________',85,23+i*68,{align:'center'})
        //   doc.text('.................................................................................................................',40,28.5+i*68)
        //   doc.text('.................................................................................................................',40,33+i*68)
        //   doc.text('.................................................................................................................',40,37+i*68)
        //   doc.text('.................................................................................................................',40,41.5+i*68)
        //   doc.text('.................................................................................................................',40,45.5+i*68)
        //   doc.text('.................................................................................................................',40,50+i*68)
        //   doc.text('.................................................................................................................',40,54+i*68)
        //   doc.text('.................................................................................................................',40,58.5+i*68)
        //   doc.text('.................................................................................................................',40,62.5+i*68)
        //   doc.text('.................................................................................................................',40,67+i*68)
        //   doc.text('.................................................................................................................',40,71+i*68)
        //   doc.text('.................................................................................................................',40,75.5+i*68)
        //   doc.text('.................................................................................................................',40,79.5+i*68)
        //   doc.text('.................................................................................................................',40,84+i*68)
        //   doc.text('FIRMAR',115,87+i*68)

        //   doc.roundedRect(130, 20+i*68, 72, 68, 1, 1, 'S')
        //   doc.line(130, 24+i*68, 202, 24+i*68)//line1
        //   doc.line(130, 84+i*68, 202, 84+i*68)//line2
        //   doc.text('DESTINATARIO '+con+':',132,23+i*68)
        //   doc.text('SELLO DE RECEPCION '+con+':',150,83+i*68)
        //   doc.text('FECHA:',132,87+i*68)
        //   doc.text('HORA:',172,87+i*68)
        //   con++
        // }
///////////////////////////




        // $( '#docpdf' ).attr('src', doc.output('datauristring'));
        // // doc.save("Pago"+date.formatDate(Date.now(),'DD-MM-YYYY')+".pdf");
        window.open(doc.output('bloburl'), '_blank');
      })
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
    impresionextra(row){
       this.$q.dialog({
        title:'Ingrese numero de página?',
         message:'Numero de Pagina permitida (2, 3, 4)',
         prompt:{
           model:'',
           isValid: val => val > 1 && val < 5, // << here is the magic
           type:'text'
         },
        cancel:true,
        persistent: true
      }).onOk(data=>{
        this.$q.loading.show()
        let n = Number(data);
        var doc = new jsPDF()

        var width = doc.internal.pageSize.getWidth()
        //INICIO CORRESPONDENCIA
        doc.setFont('times', 'bold');
        doc.setDrawColor(122);
        doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
        doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
        doc.setTextColor(158,158,158)
        doc.setFontSize(10);
        doc.text('HOJA '+n,187,14)
        doc.setFontSize(7);
        doc.text('HOJA DE RUTA',184,17)

        doc.setTextColor(0,0,0)
        //codigo en hoja de ruta extra
        doc.roundedRect(6, 11, 175, 8, 1, 1, 'S')//hoja1 hoja de ruta
        doc.setFontSize(5);
        doc.setFont('times', 'bold');
        doc.text("CODIGO",15,13.5)
        doc.setFontSize(12);
        doc.text(row.codigo,7,17)
        doc.setFont('times', 'normal');
        doc.setFontSize(5);
        doc.setFont('times', 'bold');
        doc.text("REMITENTE",60,13.5)
        doc.setFontSize(8);
        doc.setFont('times', 'normal');
        doc.text(row.remitente.toString().substring(0,35),36,17)

        doc.setFontSize(5);
        doc.setFont('times', 'bold');
        doc.text("REFERENCIA",width/2+28,13.5)

        if(row.ref.toString().length > 100){
            doc.setFontSize(4);
            doc.setFont('times', 'normal');
            let textLines=doc.splitTextToSize(row.ref.trim(),63)
            doc.text(textLines,width/2,15.5,{maxWidth: 63});
        }
        else{
            doc.setFontSize(6);
            doc.setFont('times', 'normal');
            let textLines=doc.splitTextToSize(row.ref.trim(),63)
            doc.text(textLines,width/2,15.5,{maxWidth: 63});
        }
        doc.setFontSize(5);
        doc.setFont('times', 'bold');
        doc.text("FOJAS",170,13.5)
        doc.setFontSize(8);
         doc.setFont('times', 'normal');
        doc.text(row.folio,170,17)




        doc.setFont('times', 'bold');

       let con
       switch (n) {
        case 2:
              con=3;
          break;
        case 3:
              con=7;
          break;
        case 4:
              con=11;
          break;
       }

        for (let i=0;i<4;i++){
          // doc.roundedRect(8, 52+i*80, 194, 80, 2, 2, 'S')
          doc.setDrawColor("#000000")
          doc.setLineWidth(0.5)
          doc.roundedRect(8, 20+i*68, 194, 68, 2, 2, 'S')

          doc.setDrawColor(122)
          doc.setLineWidth(0.2)

          let offsetx= 16;
          let inicuadro1 = 18,saltoeny=117;
          doc.setFontSize(9)
          doc.text('AGENDAR',21+offsetx,25+i*68,{align:'center'})
          doc.setFontSize(6)
          doc.text(['ELABORE',' MEMORANDUM','DE INSTRUCCIÓN'],21+offsetx,31+i*68,{align:'center'})
          doc.setFontSize(6)
          doc.text(['PARA SU','ATENCIÓN','PREVIA VERIFICACIÓN'],21+offsetx,39+i*68,{align:'center'})
          doc.setFontSize(6)
          doc.text(['PROCEDA',' SEGUN','CORRESPONDA'],21+offsetx,48+i*68,{align:'center'})
          doc.setFontSize(7)
          doc.text(['ELABORE',' NOTA'],21+offsetx,58+i*68,{align:'center'})
          doc.setFontSize(6)
          doc.text(['ELABORE','CONVOCATORIA','Y CIRCULAR'],21+offsetx,65+i*68,{align:'center'})
          doc.text(['ELABORE','RESOLUCIÓN','EJECUTIVA'],21+offsetx,74+i*68,{align:'center'})
          doc.setFontSize(9)
          doc.text('ARCHIVAR',21+offsetx,85+i*68,{align:'center'})


          doc.setFontSize(8)
          doc.setFont('times', 'bold');
          doc.text('REMISIÓN INTERNA:',inicuadro1-6,87+i*68,null, 90)
          doc.line(inicuadro1+6, 20+i*68, inicuadro1+6, 88+i*68)//linevertical remitente interno


          doc.roundedRect(35+offsetx, 20+i*68, 5, 8.5, 1, 1, 'S')
          doc.roundedRect(35+offsetx, 28.5+i*68, 5, 8.5, 1, 1, 'S')
          doc.roundedRect(35+offsetx, 37+i*68, 5, 8.5, 1, 1, 'S')
          doc.roundedRect(35+offsetx, 45.5+i*68, 5, 8.5, 1, 1, 'S')
          doc.roundedRect(35+offsetx, 54+i*68, 5, 8.5, 1, 1, 'S')
          doc.roundedRect(35+offsetx, 62.5+i*68, 5, 8.5, 1, 1, 'S')
          doc.roundedRect(35+offsetx, 71+i*68, 5, 8.5, 1, 1, 'S')
          doc.roundedRect(35+offsetx, 79.5+i*68, 5, 8.5, 1, 1, 'S')
          doc.line(8+offsetx, 28.5+i*68, 40+offsetx, 28.5+i*68)//line1
          doc.line(8+offsetx, 37+i*68, 40+offsetx, 37+i*68)//line2
          doc.line(8+offsetx, 45.5+i*68, 40+offsetx, 45.5+i*68)//line3
          doc.line(8+offsetx, 54+i*68, 40+offsetx, 54+i*68)//line4
          doc.line(8+offsetx, 62.5+i*68, 40+offsetx, 62.5+i*68)//line5
          doc.line(8+offsetx, 71+i*68, 40+offsetx, 71+i*68)//line5
          doc.line(8+offsetx, 79.5+i*68, 40+offsetx, 79.5+i*68)//line6

          doc.text('INSTRUCCIONES:',85+offsetx,23+i*68,{align:'center'})
          doc.text('_________________',85+offsetx,23+i*68,{align:'center'})
          doc.text('...............................................................................................................................',40+offsetx,28.5+i*68)
          doc.text('...............................................................................................................................',40+offsetx,33+i*68)
          doc.text('...............................................................................................................................',40+offsetx,37+i*68)
          doc.text('...............................................................................................................................',40+offsetx,41.5+i*68)
          doc.text('...............................................................................................................................',40+offsetx,45.5+i*68)
          doc.text('...............................................................................................................................',40+offsetx,50+i*68)
          doc.text('...............................................................................................................................',40+offsetx,54+i*68)
          doc.text('...............................................................................................................................',40+offsetx,58.5+i*68)
          doc.text('...............................................................................................................................',40+offsetx,62.5+i*68)
          doc.text('...............................................................................................................................',40+offsetx,67+i*68)
          doc.text('...............................................................................................................................',40+offsetx,71+i*68)
          doc.text('...............................................................................................................................',40+offsetx,75.5+i*68)
          doc.text('...............................................................................................................................',40+offsetx,79.5+i*68)
          doc.text('...............................................................................................................................',40+offsetx,84+i*68)
          doc.text('FIRMAR',115+offsetx,87+i*68)

          doc.roundedRect(130+offsetx, 20+i*68, 55.8, 68, 1, 1, 'S')
          doc.line(130+offsetx, 24+i*68, 202, 24+i*68)//line1
          doc.line(130+offsetx, 84+i*68, 202, 84+i*68)//line2

          doc.text('DESTINATARIO '+con+':',132+offsetx,23+i*68)
          doc.text('SELLO DE RECEPCION '+con,140+offsetx,83+i*68)
          doc.text('FECHA:',132+offsetx,87+i*68)
          doc.text('HORA:',162+offsetx,87+i*68)
          con++
        }


this.$q.loading.hide()
        window.open(doc.output('bloburl'), '_blank');

         this.$q.notify({
            message: 'Hoja de ruta extra',
            caption: 'Hoja de ruta generada exitosamente',
            color: 'green',
            icon:'done'
          });

      })

    },
    impresioncondependencias(l){
      // console.log(l)
      this.$q.loading.show()
      this.$axios.get(process.env.API+'/mail/'+l.mail_id).then(res=>{
        // console.log(res.data)
        let m=res.data
        this.$q.loading.hide()
        var doc = new jsPDF()
        let x=0
        let y=0
        //INICIO CABEZERA
        doc.setDrawColor(122);
        doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
        doc.roundedRect(8, 22, 194, 30, 2, 2, 'S')//destinatario 1
        doc.roundedRect(58, 22, 20, 30, 2, 2, 'S')//el logo HR
        doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
        doc.setFillColor(158,158,158)
        doc.line(8, 28, 58, 28)//line n
        doc.line(8, 36, 58, 36)//line fecha recepcion
        doc.line(8, 46, 58, 46)//line hora repeccion
        doc.line(78, 26, 202, 26)//line remitente
        doc.line(78, 31, 202, 31)//line entidad
        doc.line(78, 36, 202, 36)//line CITE
        doc.line(78, 41, 202, 41)//line referecnia
        doc.line(78, 46, 202, 46)//line hojas
        doc.roundedRect(70, 5, 70, 10, 2, 2, 'F') // fondo gamo
        doc.setFontSize(35);
        doc.setFont('times', 'bold');
        doc.setTextColor(255,255,255)
        doc.text('GAMO',85,14)
        doc.setTextColor(0,0,0)
        doc.setFontSize(37);
        doc.text('HR',58,38)
        doc.setFontSize(7);
        doc.text('HOJA DE RUTA',59,42)
        doc.text(m.tipo.toString(),62,48)
        doc.setTextColor(158,158,158)
        doc.setFontSize(10);
        doc.text('HOJA 1',187,14)
        doc.setFontSize(7);
        doc.text('HOJA DE RUTA',184,17)
        doc.setTextColor(0,0,0)
        doc.setFontSize(11)
        doc.text('REGISTRO DE CORRESPONDENCIA - HOJA DE RUTA',58,20)
        doc.setFontSize(15)
        doc.text('Nº',10,27)
        doc.setFont(undefined, 'normal');
        doc.text(m.codigo.toString(),40,27,'center')
        doc.setFont('times', 'bold');
        doc.setFontSize(10)
        doc.text(['FECHA DE','CREACIÓN:'],10,31)
        doc.setFont(undefined, 'normal');
        doc.text(l.fecha.toString(),45,33,'center')
        doc.setFont('times', 'bold');
        doc.text(['HORA DE','CREACIÓN:'],10,40)
        doc.setFont(undefined, 'normal');
        doc.text(l.hora.toString(),45,42,'center')
        doc.setFont('times', 'bold');
        doc.text('CITE:',10,50)
        doc.setFont('times', 'normal');
        doc.setFontSize(14)
        doc.text(m.citecontrol.toString(),40,50,'center')
        doc.setFontSize(10)
        doc.setFont('times', 'bold');
        doc.text('REMITENTE:',80,25)
        doc.setFont('times', 'normal');
        doc.text(m.remitente,152,25,'center')
        doc.setFont('times', 'bold');
        doc.text('ENTIDAD:',80,30)
        doc.setFont('times', 'normal');
        doc.text(m.institucion,152,30,'center')
        doc.setFont('times', 'bold');
        doc.text('CITE:',80,35)
        doc.setFont('times', 'normal');
        doc.setFontSize(8)
        doc.text(m.cite,120,35,'center')
        doc.setFontSize(10)
        doc.setFont('times', 'bold');
        doc.text('HOJAS:',160,35)
        doc.setFont('times', 'normal');
        doc.text(m.folio,188,35,'center')
        doc.setFont('times', 'bold');
        doc.text('REF:',80,40)
        doc.setFont('times', 'normal');
        doc.text([m.ref.substring(0,50),m.ref.substring(50,100)],148,40,'center')
        doc.setFont('times', 'bold');
        doc.text('DESTINATARIO:',80,50)
        doc.setFont(undefined, 'normal');
        doc.text(l.destinatario,150,50,'center')
        doc.setFont('times', 'bold');
        //FIN CABEZERA
        //INICIO CORRESPONDENCIA
        let con=1
        for (let i=0;i<2;i++){
          let inicuadro1 = 18, fincuadro1=97,inicuadro2=107,fincuadro2=202;
          let saltoeny=117;
          doc.roundedRect(8, 52+i*saltoeny, 194, saltoeny, 2, 2, 'S')
         //DESTINATARIOS
       //   doc.roundedRect(8, 52+i*80, 97, 37, 1, 1, 'S')
          doc.setFontSize(10)
          doc.setFont('times', 'bold');
          doc.text('DESTINATARIO',inicuadro1-4,84+i*saltoeny,null, 90)

          doc.line(inicuadro1, 52+i*saltoeny, inicuadro1, 89+i*saltoeny)//vertical2

          doc.line(inicuadro1, 56+i*saltoeny, fincuadro2, 56+i*saltoeny)//line1
          doc.line(inicuadro1, 60+i*saltoeny, fincuadro2, 60+i*saltoeny)//line2
          doc.line(inicuadro1, 64+i*saltoeny, fincuadro2, 64+i*saltoeny)//line3
          doc.line(inicuadro1, 68+i*saltoeny, fincuadro2, 68+i*saltoeny)//line4
          doc.line(inicuadro1, 72+i*saltoeny, fincuadro2, 72+i*saltoeny)//line5
          doc.line(inicuadro1, 76+i*saltoeny, fincuadro2, 76+i*saltoeny)//line6
          doc.line(inicuadro1, 80+i*saltoeny, fincuadro2, 80+i*saltoeny)//line7
          doc.line(inicuadro1, 84+i*saltoeny, inicuadro2+8, 84+i*saltoeny)//line8
          doc.line(inicuadro1-10, 89+i*saltoeny, fincuadro2, 89+i*saltoeny)//line9
          doc.line(inicuadro1+5, 52+i*saltoeny, inicuadro1+5, 89+i*saltoeny)//vertical2
          doc.line(inicuadro2+8, 52+i*saltoeny, inicuadro2+8, 89+i*saltoeny)//vertical3
          doc.line(inicuadro2+13, 52+i*saltoeny, inicuadro2+13, 89+i*saltoeny)//vertical4

          doc.setFontSize(7)
          doc.setFont('times', 'normal');
          doc.text('',inicuadro1+7,55+i*saltoeny)
          doc.text('ALCALDE MUNICIPAL',inicuadro1+7,55+i*saltoeny)
          doc.text('SECRETARIA GENERAL',inicuadro1+7,59+i*saltoeny)
          doc.text('STRIA. MPAL. DE ECONOMÍA Y HACIENDA',inicuadro1+7,63+i*saltoeny)
          doc.text('STRIA. MPAL. DE INFRAESTRUCTURA PÚBLICA',inicuadro1+7,67+i*saltoeny)
          doc.text('STRIA. MPAL. DE GESTIÓN TERRITORIAL',inicuadro1+7,71+i*saltoeny)
          doc.text('STRIA. MPAL. DE SALUD INTEGRAL Y DEPORTES',inicuadro1+7,75+i*saltoeny)
          doc.text('STRIA. MPAL. DE DESARROLLO HUMANO',inicuadro1+7,79+i*saltoeny)
          doc.text('STRIA. MPAL. DE CULTURA',inicuadro1+7,83+i*saltoeny)
          doc.text('STRIA. MPAL. DE ASUNTOS JURIDICOS',inicuadro1+7,87+i*saltoeny)

          doc.text('DIRECCIÓN DE GESTIÓN DE R.R.H.H.',inicuadro2+15,55+i*saltoeny)
          doc.text('DIRECCIÓN DE PLANIFICACIÓN INTEGRAL',inicuadro2+15,59+i*saltoeny)
          doc.text('DIRECCIÓN DE COMUNICACIÓN',inicuadro2+15,63+i*saltoeny)
          doc.text('DIRECCIÓN DE DESARROLLO ORGANIZACIONAL Y TICS',inicuadro2+15,67+i*saltoeny)
          doc.text('UNIDAD DE AUDITORIA INTERNA',inicuadro2+15,71+i*saltoeny)
          doc.text('UNIDAD DE FISCALIZACIÓN DE OBRAS',inicuadro2+15,75+i*saltoeny)
          doc.text('UNIDAD DE TRANSPARENCIA',inicuadro2+15,79+i*saltoeny)
          doc.text('OTRO:',inicuadro2+15,83+i*saltoeny)
          //doc.text('OTRO:',inicuadro2+15,87+i*saltoeny)



          doc.setFont('times', 'bold');
          //instrucciones
        //  doc.roundedRect(8, 89+i*saltoeny, 194, 80, 2, 2, 'S')
          let offsetx= 16;
          doc.setFontSize(8)
          doc.text('AGENDAR',21+offsetx,95+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['ELABORE',' MEMORANDUM','DE INSTRUCCIÓN'],21+offsetx,102+i*saltoeny,{align:'center'})
          doc.setFontSize(6)
          doc.text(['PARA SU','ATENCIÓN','PREVIA VERIFICACIÓN'],21+offsetx,112+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['PROCEDA',' SEGUN','CORRESPONDA'],21+offsetx,122+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['ELABORE',' NOTA'],21+offsetx,134+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['ELABORE','CONVOCATORIA','Y CIRCULAR'],21+offsetx,142+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['ELABORE','RESOLUCIÓN','EJECUTIVA'],21+offsetx,152+i*saltoeny,{align:'center'})
          doc.setFontSize(8)
          doc.text('ARCHIVAR',21+offsetx,165+i*saltoeny,{align:'center'})


          doc.setFontSize(10)
          doc.setFont('times', 'bold');
          doc.text('REMISIÓN INTERNA:',inicuadro1-6,168+i*saltoeny,null, 90)
          doc.line(inicuadro1+5, 89+i*saltoeny, inicuadro1+5, 169+i*saltoeny)//linevertical remitente interno

          doc.roundedRect(35+offsetx, 89+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 99+i*saltoeny, 40+offsetx, 99+i*saltoeny)//line1
          doc.roundedRect(35+offsetx, 99+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 109+i*saltoeny, 40+offsetx, 109+i*saltoeny)//line2
          doc.roundedRect(35+offsetx, 109+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 119+i*saltoeny, 40+offsetx, 119+i*saltoeny)//line3
          doc.roundedRect(35+offsetx, 119+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 129+i*saltoeny, 40+offsetx, 129+i*saltoeny)//line4
          doc.roundedRect(35+offsetx, 129+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 139+i*saltoeny, 40+offsetx, 139+i*saltoeny)//line5
          doc.roundedRect(35+offsetx, 139+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 149+i*saltoeny, 40+offsetx, 149+i*saltoeny)//line5
          doc.roundedRect(35+offsetx, 149+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 159+i*saltoeny, 40+offsetx, 159+i*saltoeny)//line6
          doc.roundedRect(35+offsetx, 159+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.setFontSize(9)
          doc.text('INSTRUCCIONES:',85+offsetx,94+i*saltoeny,{align:'center'})
          doc.text('_________________',85+offsetx,94+i*saltoeny,{align:'center'})
          if (i==0){

            if(l.accion.toString()==='CREADO'){
              doc.text(' ',41+offsetx,98+i*saltoeny)
            }
            else
            {
              doc.text(l.accion.toString().substring(0,45),41+offsetx,98+i*saltoeny)
              doc.text(l.accion.toString().substring(45,90),41+offsetx,103+i*saltoeny)
              doc.text(l.accion.toString().substring(90,135),41+offsetx,108+i*saltoeny)
              doc.text(l.accion.toString().substring(135,180),41+offsetx,113+i*saltoeny)
              doc.text(l.accion.toString().substring(180,225),41+offsetx,118+i*saltoeny)
              doc.text(l.accion.toString().substring(225,270),41+offsetx,123+i*saltoeny)
              doc.text(l.accion.toString().substring(270,315),41+offsetx,128+i*saltoeny)
            }
            doc.setFont(undefined, 'bold');
          }


          doc.text('.................................................................................................................',40+offsetx,99+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,104+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,109+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,114+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,119+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,124+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,129+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,134+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,139+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,144+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,149+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,154+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,159+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,164+i*saltoeny)
          doc.text('FIRMAR',115+offsetx,167+i*saltoeny)

          doc.roundedRect(130+offsetx, 89+i*saltoeny, 55.8, 80, 1, 1, 'S')
          doc.line(130+offsetx, 96+i*saltoeny, 202, 96+i*saltoeny)//line1
          doc.line(130+offsetx, 163+i*saltoeny, 202, 163+i*saltoeny)//line2
          doc.text('DESTINATARIO '+con+':',132+offsetx,94+i*saltoeny)
          doc.text('SELLO DE RECEPCION '+con,145+offsetx,162+i*saltoeny)
          doc.text('FECHA:',132+offsetx,167+i*saltoeny)
          doc.text('HORA:',164+offsetx,167+i*saltoeny)
          con++
        }


        window.open(doc.output('bloburl'), '_blank');
      })

    },
    impresioncondependenciassecretariageneral(l){
      // console.log(l)
      this.$q.loading.show()
      this.$axios.get(process.env.API+'/mail/'+l.mail_id).then(res=>{
        // console.log(res.data)
        let m=res.data
        this.$q.loading.hide()
        var doc = new jsPDF()
        let x=0
        let y=0
        //INICIO CABEZERA
        doc.setDrawColor(122);
        doc.roundedRect(5, 10, 200, 282, 2, 2, 'S')//principal
        doc.roundedRect(8, 22, 194, 30, 2, 2, 'S')//destinatario 1
        doc.roundedRect(58, 22, 20, 30, 2, 2, 'S')//el logo HR
        doc.roundedRect(183, 11, 20, 8, 1, 1, 'S')//hoja1 hoja de ruta
        doc.setFillColor(158,158,158)
        doc.line(8, 28, 58, 28)//line n
        doc.line(8, 36, 58, 36)//line fecha recepcion
        doc.line(8, 46, 58, 46)//line hora repeccion
        doc.line(78, 26, 202, 26)//line remitente
        doc.line(78, 31, 202, 31)//line entidad
        doc.line(78, 36, 202, 36)//line CITE
        doc.line(78, 41, 202, 41)//line referecnia
        doc.line(78, 46, 202, 46)//line hojas
        doc.roundedRect(70, 5, 70, 10, 2, 2, 'F') // fondo gamo
        doc.setFontSize(35);
        doc.setFont('times', 'bold');
        doc.setTextColor(255,255,255)
        doc.text('GAMO',85,14)
        doc.setTextColor(0,0,0)
        doc.setFontSize(37);
        doc.text('HR',58,38)
        doc.setFontSize(7);
        doc.text('HOJA DE RUTA',59,42)
        doc.text(m.tipo.toString(),62,48)
        doc.setTextColor(158,158,158)
        doc.setFontSize(10);
        doc.text('HOJA 1',187,14)
        doc.setFontSize(7);
        doc.text('HOJA DE RUTA',184,17)
        doc.setTextColor(0,0,0)
        doc.setFontSize(11)
        doc.text('REGISTRO DE CORRESPONDENCIA - HOJA DE RUTA',58,20)
        doc.setFontSize(15)
        doc.text('Nº',10,27)
        doc.setFont(undefined, 'normal');
        doc.text(m.codigo.toString(),40,27,'center')
        doc.setFont('times', 'bold');
        doc.setFontSize(10)
        doc.text(['FECHA DE','CREACIÓN:'],10,31)
        doc.setFont(undefined, 'normal');
        doc.text(l.fecha.toString(),45,33,'center')
        doc.setFont('times', 'bold');
        doc.text(['HORA DE','CREACIÓN:'],10,40)
        doc.setFont(undefined, 'normal');
        doc.text(l.hora.toString(),45,42,'center')
        doc.setFont('times', 'bold');
        doc.text('CITE:',10,50)
        doc.setFont('times', 'normal');
        doc.setFontSize(14)
        doc.text(m.citecontrol.toString(),40,50,'center')
        doc.setFontSize(10)
        doc.setFont('times', 'bold');
        doc.text('REMITENTE:',80,25)
        doc.setFont('times', 'normal');
        doc.text(m.remitente,152,25,'center')
        doc.setFont('times', 'bold');
        doc.text('ENTIDAD:',80,30)
        doc.setFont('times', 'normal');
        doc.text(m.institucion,152,30,'center')
        doc.setFont('times', 'bold');
        doc.text('CITE:',80,35)
        doc.setFont('times', 'normal');
        doc.setFontSize(8)
        doc.text(m.cite,120,35,'center')
        doc.setFontSize(10)
        doc.setFont('times', 'bold');
        doc.text('HOJAS:',160,35)
        doc.setFont('times', 'normal');
        doc.text(m.folio,188,35,'center')
        doc.setFont('times', 'bold');
        doc.text('REF:',80,40)
        doc.setFont('times', 'normal');
        doc.text([m.ref.substring(0,50),m.ref.substring(50,100)],148,40,'center')
        doc.setFont('times', 'bold');
        doc.text('A:',80,50)
        doc.setFont(undefined, 'normal');
        doc.text(l.user2.name,145,50,'center');
        doc.setFont('times', 'bold');
        //FIN CABEZERA
        //INICIO CORRESPONDENCIA
        let con=1
        for (let i=0;i<2;i++){
          let inicuadro1 = 18, fincuadro1=97,inicuadro2=107,fincuadro2=202;
          let saltoeny=117;
          doc.roundedRect(8, 52+i*saltoeny, 194, saltoeny, 2, 2, 'S')
         //DESTINATARIOS
       //   doc.roundedRect(8, 52+i*80, 97, 37, 1, 1, 'S')
          doc.setFontSize(10)
          doc.setFont('times', 'bold');
          doc.text('DESTINATARIO',inicuadro1-4,84+i*saltoeny,null, 90)

          doc.line(inicuadro1, 52+i*saltoeny, inicuadro1, 89+i*saltoeny)//vertical2

          doc.line(inicuadro1, 56+i*saltoeny, fincuadro2, 56+i*saltoeny)//line1
          doc.line(inicuadro1, 60+i*saltoeny, fincuadro2, 60+i*saltoeny)//line2
          doc.line(inicuadro1, 64+i*saltoeny, fincuadro2, 64+i*saltoeny)//line3
          doc.line(inicuadro1, 68+i*saltoeny, fincuadro2, 68+i*saltoeny)//line4
          doc.line(inicuadro1, 72+i*saltoeny, fincuadro2, 72+i*saltoeny)//line5
          doc.line(inicuadro1, 76+i*saltoeny, fincuadro2, 76+i*saltoeny)//line6
          doc.line(inicuadro1, 80+i*saltoeny, fincuadro2, 80+i*saltoeny)//line7
          doc.line(inicuadro1, 84+i*saltoeny, inicuadro2+8, 84+i*saltoeny)//line8
          doc.line(inicuadro1-10, 89+i*saltoeny, fincuadro2, 89+i*saltoeny)//line9
          doc.line(inicuadro1+5, 52+i*saltoeny, inicuadro1+5, 89+i*saltoeny)//vertical2
          doc.line(inicuadro2+8, 52+i*saltoeny, inicuadro2+8, 89+i*saltoeny)//vertical3
          doc.line(inicuadro2+13, 52+i*saltoeny, inicuadro2+13, 89+i*saltoeny)//vertical4

          doc.setFontSize(7)
          doc.setFont('times', 'normal');
          doc.text('',inicuadro1+7,55+i*saltoeny)
          doc.text('ALCALDE MUNICIPAL',inicuadro1+7,55+i*saltoeny)
          doc.text('SECRETARIA GENERAL',inicuadro1+7,59+i*saltoeny)
          doc.text('STRIA. MPAL. DE ECONOMÍA Y HACIENDA',inicuadro1+7,63+i*saltoeny)
          doc.text('STRIA. MPAL. DE INFRAESTRUCTURA PÚBLICA',inicuadro1+7,67+i*saltoeny)
          doc.text('STRIA. MPAL. DE GESTIÓN TERRITORIAL',inicuadro1+7,71+i*saltoeny)
          doc.text('STRIA. MPAL. DE SALUD INTEGRAL Y DEPORTES',inicuadro1+7,75+i*saltoeny)
          doc.text('STRIA. MPAL. DE DESARROLLO HUMANO',inicuadro1+7,79+i*saltoeny)
          doc.text('STRIA. MPAL. DE CULTURA',inicuadro1+7,83+i*saltoeny)
          doc.text('STRIA. MPAL. DE ASUNTOS JURIDICOS',inicuadro1+7,87+i*saltoeny)

          doc.text('DIRECCIÓN DE GESTIÓN DE R.R.H.H.',inicuadro2+15,55+i*saltoeny)
          doc.text('DIRECCIÓN DE PLANIFICACIÓN INTEGRAL',inicuadro2+15,59+i*saltoeny)
          doc.text('DIRECCIÓN DE COMUNICACIÓN',inicuadro2+15,63+i*saltoeny)
          doc.text('DIRECCIÓN DE DESARROLLO ORGANIZACIONAL Y TICS',inicuadro2+15,67+i*saltoeny)
          doc.text('UNIDAD DE AUDITORIA INTERNA',inicuadro2+15,71+i*saltoeny)
          doc.text('UNIDAD DE FISCALIZACIÓN DE OBRAS',inicuadro2+15,75+i*saltoeny)
          doc.text('UNIDAD DE TRANSPARENCIA',inicuadro2+15,79+i*saltoeny)
          doc.text('OTRO:',inicuadro2+15,83+i*saltoeny)
          //doc.text('OTRO:',inicuadro2+15,87+i*saltoeny)



          doc.setFont('times', 'bold');
          //instrucciones
        //  doc.roundedRect(8, 89+i*saltoeny, 194, 80, 2, 2, 'S')
          let offsetx= 16;
          doc.setFontSize(8)
          doc.text('AGENDAR',21+offsetx,95+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['ELABORE',' MEMORANDUM','DE INSTRUCCIÓN'],21+offsetx,102+i*saltoeny,{align:'center'})
          doc.setFontSize(6)
          doc.text(['PARA SU','ATENCIÓN','PREVIA VERIFICACIÓN'],21+offsetx,112+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['PROCEDA',' SEGUN','CORRESPONDA'],21+offsetx,122+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['ELABORE',' NOTA'],21+offsetx,134+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['ELABORE','CONVOCATORIA','Y CIRCULAR'],21+offsetx,142+i*saltoeny,{align:'center'})
          doc.setFontSize(7)
          doc.text(['ELABORE','RESOLUCIÓN','EJECUTIVA'],21+offsetx,152+i*saltoeny,{align:'center'})
          doc.setFontSize(8)
          doc.text('ARCHIVAR',21+offsetx,165+i*saltoeny,{align:'center'})


          doc.setFontSize(10)
          doc.setFont('times', 'bold');
          doc.text('REMISIÓN INTERNA:',inicuadro1-6,168+i*saltoeny,null, 90)
          doc.line(inicuadro1+5, 89+i*saltoeny, inicuadro1+5, 169+i*saltoeny)//linevertical remitente interno

          doc.roundedRect(35+offsetx, 89+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 99+i*saltoeny, 40+offsetx, 99+i*saltoeny)//line1
          doc.roundedRect(35+offsetx, 99+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 109+i*saltoeny, 40+offsetx, 109+i*saltoeny)//line2
          doc.roundedRect(35+offsetx, 109+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 119+i*saltoeny, 40+offsetx, 119+i*saltoeny)//line3
          doc.roundedRect(35+offsetx, 119+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 129+i*saltoeny, 40+offsetx, 129+i*saltoeny)//line4
          doc.roundedRect(35+offsetx, 129+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 139+i*saltoeny, 40+offsetx, 139+i*saltoeny)//line5
          doc.roundedRect(35+offsetx, 139+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 149+i*saltoeny, 40+offsetx, 149+i*saltoeny)//line5
          doc.roundedRect(35+offsetx, 149+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.line(7+offsetx, 159+i*saltoeny, 40+offsetx, 159+i*saltoeny)//line6
          doc.roundedRect(35+offsetx, 159+i*saltoeny, 5, 10, 1, 1, 'S')
          doc.setFontSize(9)
          doc.text('INSTRUCCIONES:',85+offsetx,94+i*saltoeny,{align:'center'})
          doc.text('_________________',85+offsetx,94+i*saltoeny,{align:'center'})
          if (i==0){

            if(l.accion.toString()==='CREADO'){
              doc.text(' ',41+offsetx,98+i*saltoeny)
            }
            else
            {
              doc.text(l.accion.toString().substring(0,45),41+offsetx,98+i*saltoeny)
              doc.text(l.accion.toString().substring(45,90),41+offsetx,103+i*saltoeny)
              doc.text(l.accion.toString().substring(90,135),41+offsetx,108+i*saltoeny)
              doc.text(l.accion.toString().substring(135,180),41+offsetx,113+i*saltoeny)
              doc.text(l.accion.toString().substring(180,225),41+offsetx,118+i*saltoeny)
              doc.text(l.accion.toString().substring(225,270),41+offsetx,123+i*saltoeny)
              doc.text(l.accion.toString().substring(270,315),41+offsetx,128+i*saltoeny)
            }
            doc.setFont(undefined, 'bold');
          }


          doc.text('.................................................................................................................',40+offsetx,99+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,104+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,109+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,114+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,119+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,124+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,129+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,134+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,139+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,144+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,149+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,154+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,159+i*saltoeny)
          doc.text('.................................................................................................................',40+offsetx,164+i*saltoeny)
          doc.text('FIRMAR',115+offsetx,167+i*saltoeny)

          doc.roundedRect(130+offsetx, 89+i*saltoeny, 55.8, 80, 1, 1, 'S')
          doc.line(130+offsetx, 96+i*saltoeny, 202, 96+i*saltoeny)//line1
          doc.line(130+offsetx, 163+i*saltoeny, 202, 163+i*saltoeny)//line2
          doc.text('DESTINATARIO '+con+':',132+offsetx,94+i*saltoeny)
          doc.text('SELLO DE RECEPCION '+con,145+offsetx,162+i*saltoeny)
          doc.text('FECHA:',132+offsetx,167+i*saltoeny)
          doc.text('HORA:',164+offsetx,167+i*saltoeny)
          con++
        }


        window.open(doc.output('bloburl'), '_blank');
      })

    },
        impresion2(id){
      // console.log(id)
      // return false
      this.$axios.post(process.env.API+'/impblanco/'+id).then(res=>{
        console.log(res.data);
        let myWindow = window.open("", "Imprimir", "width=1000,height=1000");
        myWindow.document.write(res.data);
        myWindow.document.close();
        myWindow.focus();
        setTimeout(function(){
          myWindow.print();
          myWindow.close();
        },700);
      })
    },
    impresionticket(data){
        if(this.$store.state.login.user.id===106){
          this.$q.loading.show()
          const doc = new jsPDF({
            orientation: 'portrait',
            unit: "cm",
            format: [8,8],
          });
          var imgData = 'data:image/png;base64,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'

            doc.setFontSize(12);
            doc.setFont('times', 'bold');
            doc.text('CODIGO: '+data.codigo,1.7,1.2)
            doc.setFontSize(10);
            doc.setFont('times', 'normal');
            doc.text('FECHA: '+data.fecha,2.7,1.8)

            doc.addImage(imgData, 'PNG', 2.2, 2.1, 3.5, 1.2)
            doc.setFontSize(8);
            doc.setFont('times', 'normal');
            doc.text('Seguimiento en: www.gamo.gob.bo',1.2,0.6)

            // Set the document to automatically print via JS
            doc.autoPrint();
            doc.output('dataurlnewwindow');
            console.log("IMPRESION DE TICKET")
            // window.open(doc.output('bloburl'), '_blank');


          this.$q.loading.hide()
        }
        else{
          return false
        }
    //  doc.autoPrint({variant: 'non-conform'});
    //   doc.save('autoprint.pdf')

    },
    archivar(mail){
      this.$q.dialog({
        title:'Seguro de archivar?',
         message:'Motivo de archivar (mínimo 4 carácteres)',
         prompt:{
           model:'',
           isValid: val => val.length > 4, // << here is the magic
           type:'text'
         },
        cancel:true,
        persistent: true
      }).onOk(data=>{
        // console.log(mail)
        this.$q.loading.show()
        var today = new Date();
        var now = today.toLocaleString();
        let mensaje = `(${now}): ${data}`
        this.$axios.post(process.env.API+'/anulado',{id:mail.id,archivado:mensaje}).then(res=>{
          // console.log(res.data)
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
    desarchivar(mail){
      this.$q.dialog({
        title:'Seguro de desarchivar?',
         message:'Motivo de desarchivar (mínimo 4 carácteres)',
         prompt:{
           model:'',
           isValid: val => val.length > 4, // << here is the magic
           type:'text'
         },
        cancel:true,
        persistent: true
      }).onOk(data=>{
        // console.log(mail)
        var today = new Date();
        var now = today.toLocaleString();
        let mensaje = `(${now}): ${data}`
        this.$q.loading.show()
        this.$axios.post(process.env.API+'/desarchivar',{id:mail.id,desarchivado:mensaje}).then(res=>{
          // console.log(res.data)
          this.misdatos();
          this.$q.notify({
            message: 'Desarchivado',
            caption: 'Registro desarchivado',
            color: 'green',
            icon:'done'
          });
        })
      })
    },
    archivo(mail){
      console.log(mail)
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
    actualizar(){
        this.filter=''
        this.misdatos()
    },
    misdatos(page = 0,filter,rowsPerPage=10){
      //this.$q.loading.show()
      this.loading=true
      this.$axios.get(process.env.API+'/micorre',{params:{page: page,filter:filter,rowsPerPage: rowsPerPage,tipoasignacion:this.tipoasignacion}}).then(res=>{
          console.log('micorre:',res)

        // this.mails=res.data
        this.mails=[]
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
          ['1 mes', 'en 1 mes'],
          ['hace %s meses', 'en %s meses'],
          ['hace 1 año', 'en 1 año'],
          ['hace %s años', 'en %s años']
        ][index]);

        // console.log( format(Date.now() - 11 * 1000 * 60 * 60,'es_ES'))
        this.pagination.page = res.data.current_page
        this.pagination.rowsPerPage = res.data.per_page
        this.pagination.rowsNumber = res.data.total
        console.log('pagination',this.pagination)

        res.data.data.forEach(r=>{
          console.log("r: ",r)
          let cancelarremision = false
          let padrelog = []
          for(let log of r.mail.logs){
                if(log.user_id2 ===this.$store.state.login.user.id && log.estado==="REMITIDO")
                {
                  padrelog.push(log.id)
                }
          }
          console.log("padreids",padrelog," idmail",r.mail_id)
              //let ultimoremitido= padrelog[padrelog.length-2]// solo muestra el ultimo
          for(let padreid of padrelog){
              if(padreid == r.id){
                    for(let log2 of r.mail.logs){
                      if(log2.user_id==this.$store.state.login.user.id && log2.estado != "EN PROCESO" && log2.log_id==padreid){
                        cancelarremision=true
                        console.log("cancelar remision en true", r.id)
                          break;
                      }
                   }
              }
          }



          if(padrelog.length > 1 &&
          r.mail.logs.length>1 &&
          r.log_id===null &&
          r.mail.logs[1].estado=='REMITIDO' &&
          r.user2.id ===this.$store.state.login.user.id)
          {
             console.log("no muestra creado de un mail que ya tiene varios remitidos",r.mail.codigo)
          }
          else
          {
            const dias=format(r.mail.fecha+' '+r.mail.hora,'es_ES')
            this.mails.push({
            id:r.id,
            mail_id:r.mail_id,
            hora:r.hora,
            citecontrol:r.mail.citecontrol,
            cite:r.mail.cite,
            codigo:r.mail.codigo,
            tipo:r.mail.tipo,
            tipo2:r.mail.tipo2,
            ref:r.mail.ref,
            remitente:r.mail.remitente,
            destinatario:r.mail.destinatario,
            cargo:r.mail.cargo,
            institucion:r.mail.institucion,
            fecha:r.mail.fecha,
            fechacarta:r.mail.fechacarta,
            estado:r.estado,
            folio:r.mail.folio,
            archivo:r.mail.archivo,
            codinterno:r.mail.codinterno,
            codexterno:r.mail.codexterno,
            logs:r.mail.logs,
            dias:dias,
            nopuedecancelarremision: cancelarremision,
            user_id:r.mail.user_id,
            user1: r.user===null?'':r.user.name,
            user2:r.user2.name,
            accion:r.mail.logs[1]!=undefined?r.mail.logs[1].accion:'',
            acciondoc:r.accion,
            archivadodoc:r.archivado
          })

          }
        })
        this.loading=false
        this.$q.loading.hide()
        console.log('mails: ',this.mails)
      })
    },
    handleRequest(props){
        console.log('halderesquest: ',props)
        if(props.pagination.rowsPerPage===0){
          props.pagination.rowsPerPage=this.pagination.rowsNumber
        }
        this.misdatos(props.pagination.page,props.filter,props.pagination.rowsPerPage)
    },
    buscar(){
      //handleRequest()
      console.log('filter:',this.filter)
      this.misdatos(this.pagination.page,this.filter,this.pagination.rowsPerPage)
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
    guardar(){
      if (this.dato.tipo==undefined||this.dato.tipo==null||this.dato.tipo==''){
        this.$q.notify({
          message:'Porfavor colocar interno o externo',
          color:'red',
          icon:'error'
        })
        return false
      }
      this.$q.dialog({
        title:"Seguro de registrar?",
        // message:"",
        cancel:true,
        persistent:true
      }).onOk(()=>{
        // if (!confirm("seguro de registrar?")){
        //   return false
        // }
        // console.log(this.remitente)
        // return false
        this.dato.remitente=this.remitente
        this.dato.destinatario=this.destinatario
        this.dato.cargo=this.cargo
        this.dato.institucion=this.institucion
        this.dato.codigo=this.codigo
        this.dato.internosg=this.internosg
        if(this.dato.id==undefined || this.dato.id==''){
          // console.log('new')
          this.$q.loading.show()
          this.$axios.post(process.env.API+'/mail',this.dato).then(res=>{
            console.log(res.data)
            this.dato={tipo:'EXTERNO',fecha:date.formatDate(Date.now(),'YYYY-MM-DD'),folio:1};
            this.remitente=''
            this.destinatario=''
            this.cargo=''
            this.institucion=''
            this.filter=''
            this.internosg=false
            this.codigo= res.data.codigo
            this.misdatos()
            this.misremitentes()
            this.misdestinatarios()
            this.crear=false
            this.impresionticket(res.data)

            // this.$q.loading.hide()
          }).catch(err=>{
            console.log("error",err)
            this.$q.loading.hide()
            this.$q.notify({
              message:err.response.data.message,
              color:'red',
              icon:'error'
            })
          })
          console.log("datos fuera de axios",this.codigo)

          }
        else{
          this.$q.loading.show()
          this.$axios.post(process.env.API+'/updatemail',this.dato).then(res=>{
            console.log("RES.DATA",res.data)
            //return false
            this.dato={tipo:'EXTERNO',fecha:date.formatDate(Date.now(),'YYYY-MM-DD'),folio:1};
            this.remitente=''
            this.destinatario=''
            this.cargo=''
            this.institucion=''
            // console.log(res.data)
            this.misdatos(this.pagination.page,this.filter,this.pagination.rowsPerPage)
            this.misremitentes()
            this.misdestinatarios()
            this.crear=false
            this.impresionticket(res.data)
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
      })

    },
    cancelarremision(data){
      let logpadreid=[]
      this.$q.dialog({
        title:'Confirme por favor',
         message:'¿Esta seguro de cancelar la derivación?',
        cancel:true,
        persistent: true
      }).onOk(()=>{
     this.$q.loading.show()
      //encontrar al padre del lo ultimo remitido
      for(const element of data.logs){
        if(element.user_id2 ===this.$store.state.login.user.id && element.estado==="REMITIDO"){
          logpadreid.push(element.id)
        }
      }
      console.log("IDLOG principal:",logpadreid)
      //buscar hijos que pertenezcan al ese padre
      this.$axios.post(process.env.API+'/buscarhijos',{logpadreid:logpadreid[logpadreid.length-1]}).then(res=>{
            console.log("resp axios",res)
          this.misdatos(this.pagination.page,this.filter,this.pagination.rowsPerPage)
          if(res.data){
            this.$q.notify({
            message: 'DERIVACION CANCELADA',
            caption: 'Proceso exitoso!!',
            color: 'green',
            icon:'done'
          });
          }else{
             this.$q.notify({
            message: 'NO SE PUDO CANCELAR LA DERIVACION',
            caption: 'No se pudo cancelar la derivación, quizas por que ya acepto la correspondecia el destinatario',
            color: 'red',
            icon:'error'
          });
          }

      })

        })


    }
  }


}
</script>

<style scoped>

</style>
