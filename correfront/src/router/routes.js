import Login from "pages/Login";
import Recepcion from "pages/Recepcion";
import User from "pages/User";
import Seguimiento from "pages/Seguimiento";
// import Asignacion from "pages/Asignacion";
import Misrecepciones from "pages/Misrecepciones";
import MainLayout from "layouts/MainLayout";
import Consulta from "pages/Consulta";
import MainLayoutPublico from "layouts/MainLayoutPublico";
import Reportecorrespondencia from "pages/Reportecorrespondencia";
import Reportecorrespondenciaremitida from "pages/Reportecorrespondenciaremitida";
import Reportecorrespondenciarecibida from "pages/Reportecorrespondenciarecibida";
import Reportecorrespondenciapendiente from "pages/Reportecorrespondenciapendiente";
import Reportecorrespondenciaarchivado from "pages/Reportecorrespondenciaarchivado.vue";
import Reporteexcelporunidad from "pages/Reporteexcelporunidad.vue";

const routes = [
  {
    path: '/',
    component: MainLayout,
    children: [
      { path: '', component: Login },
      { path: '/recepcion', component: Recepcion,meta: {requiresAuth: true,} },
      { path: '/user', component: User,meta: {requiresAuth: true,} },
      { path: '/seguimiento', component: Seguimiento,meta: {requiresAuth: true,} },
      {
        path: '/asignacion/:tipoasignacion',
        component: () => import(/* webpackChunkName: "misasignaciones" */'src/pages/asignacion.vue'),
        meta: {requiresAuth: true},
        props: (route)=> {
          const {tipoasignacion} = route.params
          return {tipoasignacion}
        }
      },
      { path: '/misrecepciones', component: Misrecepciones,meta: {requiresAuth: true,} },
      { path: '/reportecorrespondencia', component: Reportecorrespondencia,meta: {requiresAuth: true,} },
      { path: '/reportecorrespondenciaremitida', component: Reportecorrespondenciaremitida,meta: {requiresAuth: true,} },
      { path: '/reportecorrespondenciarecibida', component: Reportecorrespondenciarecibida,meta: {requiresAuth: true,} },
      { path: '/reportecorrespondenciapendiente', component: Reportecorrespondenciapendiente,meta: {requiresAuth: true,} },
      { path: '/reportecorrespondenciaarchivada', component: Reportecorrespondenciaarchivado,meta: {requiresAuth: true,} },
      { path: '/reporteremitidosexcel', component: Reporteexcelporunidad,meta: {requiresAuth: true,} },
    ]
  },
  {
    path: '/consulta',
    component: MainLayoutPublico,
    children: [
      { path: '', component: Consulta },
    ]
  },
  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/Error404.vue')
  }
]

export default routes
