<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />
        <q-toolbar-title>
          {{$store.state.login.user.name}}
        </q-toolbar-title>

        <div>
        <q-btn v-if="$store.getters['login/isLoggedIn']" label="Salir" @click="logout"  color="negative" icon="logout" size="xs" />
        </div>
      </q-toolbar>
      <div class="q-px-lg q-pt-xs q-mb-md" >
        <div class="text-h5 text-bold">
          <template v-if="!$store.getters['login/isLoggedIn']">
          SIC GAMO <div style="font-size:14px">SISTEMA DE INFORMACIÓN DE CORRESPONDENCIA GAMO</div>

          </template>
          <template v-else>
            Unidad: {{$store.state.login.user.unit.nombre}}
          </template>
        </div>
        <div class="text-subtitle1">{{ now }}</div>
      </div>
      <q-img src="img/fondo.jpg" class="header-image absolute-top" />
    </q-header>
    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      :width="250"
      :breakpoint="600"
    >
      <q-scroll-area style="height: calc(100% - 130px); margin-top: 130px; border-right: 1px solid #ddd">
        <q-list padding>
          <q-item
            clickable
            exact
            to="/"
            v-if="!$store.getters['login/isLoggedIn']"
          >
            <q-item-section
              avatar
            >
              <q-icon name="login" />
            </q-item-section>

            <q-item-section>
              <q-item-label>Ingresar</q-item-label>
              <q-item-label caption>
                Ingreso al sistema
              </q-item-label>
            </q-item-section>
          </q-item>

          <q-item
            v-if="$store.state.login.boolusuarios"
            clickable
            to="/user"
          >
            <q-item-section
              avatar
            >
              <q-icon name="people" />
            </q-item-section>

            <q-item-section>
              <q-item-label>Usuarios</q-item-label>
              <q-item-label caption>
                Control de usuarios
              </q-item-label>
            </q-item-section>
          </q-item>

          <q-item
            v-if="$store.state.login.boolrecepcion"
            clickable
            to="/recepcion"
          >
            <q-item-section
              avatar
            >
              <q-icon name="article" />
            </q-item-section>

            <q-item-section>
              <q-item-label>Registro de correspondencia</q-item-label>
              <q-item-label caption>
                Recepciones de correspondencia
              </q-item-label>
            </q-item-section>
          </q-item>


          <q-expansion-item
            expand-separator
            icon="mail"
            label="Mis asignaciones"
            caption="Mi correspondencia"
            default-opened
            v-if="$store.state.login.booldesignacion"
            >

              <q-item dense clickable v-ripple class="q-pl-xl" to="/asignacion/todo">
                <q-item-section avatar>
                  <q-icon name="source" />
                </q-item-section>
                <q-item-section>Todo</q-item-section>
              </q-item>
              <q-item dense clickable v-ripple class="q-pl-xl" to="/asignacion/recibidos">
                <q-item-section avatar>
                  <q-icon name="receipt" />
                </q-item-section>
                <q-item-section>Recibidos</q-item-section>
              </q-item>
              <q-item dense clickable v-ripple class="q-pl-xl" to="/asignacion/pendientes">
                <q-item-section avatar>
                  <q-icon name="schedule" />
                </q-item-section>
                <q-item-section>Pendientes</q-item-section>
              </q-item>
              <q-item dense clickable v-ripple class="q-pl-xl" to="/asignacion/enviados">
                <q-item-section avatar>
                  <q-icon name="send" />
                </q-item-section>
                <q-item-section>Enviados</q-item-section>
              </q-item>
              <q-item clickable v-ripple class="q-pl-xl" to="/asignacion/archivados">
                <q-item-section avatar>
                  <q-icon name="archive" />
                </q-item-section>
                <q-item-section>Archivados</q-item-section>
              </q-item>


          </q-expansion-item>

          <q-item v-if="$store.state.login.boolseguimiento" clickable to="/seguimiento">
            <q-item-section avatar>
              <q-icon name="query_stats" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Seguimiento</q-item-label>
              <q-item-label caption>
                Seguimiento de archivos
              </q-item-label>
            </q-item-section>
          </q-item>
           <q-expansion-item
            expand-separator
            icon="summarize"
            label="Reportes"
            caption="Reporte de correspondencia"
            v-if="$store.state.login.booldesignacion"
            >
          <q-item dense v-if="$store.state.login.boolseguimiento" class="q-pl-xl" clickable to="/reportecorrespondenciapendiente">
            <q-item-section avatar>
              <q-icon name="print" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Correpondencia PENDIENTE</q-item-label>
              <q-item-label caption>
                correspondencia Pendiente
              </q-item-label>
            </q-item-section>
          </q-item>
          <q-item dense v-if="$store.state.login.boolseguimiento" class="q-pl-xl" clickable to="/reportecorrespondencia">
            <q-item-section avatar>
              <q-icon name="print" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Correpondencia creada</q-item-label>
              <q-item-label caption>
                Reporte de correspondencia
              </q-item-label>
            </q-item-section>
          </q-item>

          <q-item dense v-if="$store.state.login.boolseguimiento" class="q-pl-xl" clickable to="/reportecorrespondenciaremitida">
            <q-item-section avatar>
              <q-icon name="print" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Correpondencia Remitida</q-item-label>
              <q-item-label caption>
                Reporte de correspondencia
              </q-item-label>
            </q-item-section>
          </q-item>


          <q-item dense v-if="$store.state.login.boolseguimiento" class="q-pl-xl" clickable to="/reportecorrespondenciarecibida">
            <q-item-section avatar>
              <q-icon name="print" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Correpondencia Recibida</q-item-label>
              <q-item-label caption>
                Reporte de correspondencia
              </q-item-label>
            </q-item-section>
          </q-item>
          <q-item dense v-if="$store.state.login.boolseguimiento" class="q-pl-xl" clickable to="/reportecorrespondenciaarchivada">
            <q-item-section avatar>
              <q-icon name="print" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Correpondencia Archivada</q-item-label>
              <q-item-label caption>
                Reporte de correspondencia
              </q-item-label>
            </q-item-section>
          </q-item>

          <q-item dense v-if="$store.state.login.boolreporteexcel" class="q-pl-xl" clickable to="/reporteremitidosexcel">
            <q-item-section avatar>
              <q-icon name="print" />
            </q-item-section>
            <q-item-section>
              <q-item-label>Correpondencia general por unidad</q-item-label>
              <q-item-label caption>
                Reporte por unidad
              </q-item-label>
            </q-item-section>
          </q-item>

        </q-expansion-item>
          <q-item v-if="$store.state.login.boolmisrecepciones" clickable to="/misrecepciones">
            <q-item-section avatar>
              <q-icon name="picture_as_pdf" />
            </q-item-section>

            <q-item-section>
              <q-item-label>Mis recepciones</q-item-label>
              <q-item-label caption>
                Historial de mis recepciones
              </q-item-label>
            </q-item-section>
          </q-item>


          <q-item v-if="$store.getters['login/isLoggedIn']" clickable @click="logout">
            <q-item-section avatar>
              <q-icon name="logout" />
            </q-item-section>

            <q-item-section>
              <q-item-label>Salir</q-item-label>
              <q-item-label caption>
                Salir del sistema
              </q-item-label>
            </q-item-section>
          </q-item>

        </q-list>
      </q-scroll-area>

      <q-img class="absolute-top" src="img/fondo.jpg" style="height: 130px">
        <div class="absolute-bottom bg-transparent ">
          <!--          <q-avatar size="56px" class="q-mb-sm">-->
          <!--            <img src="https://cdn.quasar.dev/img/boy-avatar.png">-->
          <!--          </q-avatar>-->
          <div class="text-weight-bold">Correspondencia </div>
          <div>Menu</div>
        </div>
      </q-img>
    </q-drawer>

    <q-page-container>
      <router-view :key="$route.fullPath"/>
    </q-page-container>
  </q-layout>
</template>

<script>
import {date} from 'quasar'
export default {
  data(){
    return{
      leftDrawerOpen : false,
      now :date.formatDate(Date.now(), 'dddd D  MMMM', {
        days: ['Domingo', 'Lunes','Martes','Miercoles','Jueves','Viernes','Sabado' /* and all the rest of days - remember starting with Sunday */],
        daysShort: ['Dum', 'Lun', /* and all the rest of days - remember starting with Sunday */],
        months: ['Enero', 'Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre' /* and all the rest of months */],
        monthsShort: ['Ian', 'Feb', /* and all the rest of months */]
      }),
      unidad:'aa'
    }
  },
  created() {
    // console.log(this.$store.getters['login/user'])
    // this.unidad=this.$store.getters['login/user'];
  },
  methods:{
    toggleLeftDrawer () {
      this.leftDrawerOpen = !this.leftDrawerOpen
    },
    logout () {
      this.$q.loading.show()
      this.$store.dispatch('login/logout')
        .then(() => {
          this.$q.loading.hide()
          this.$router.push('/')
        })
    },
  }
}
</script>
<style lang="scss">
.header-image{
  height: 100%;
  z-index: -1;
  opacity: 0.2;
  filter: grayscale(100%);
}
</style>
