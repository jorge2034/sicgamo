<template>
  <q-page class="q-pa-md">
    <div class="row">
      <div class="col-12 col-md-2"></div>
      <div class="col-12 col-md-8">
        <q-card>
          <q-tabs
            v-model="tab"
            dense
            class="text-grey"
            active-color="primary"
            indicator-color="primary"
            align="justify"
            narrow-indicator
          >
            <q-tab name="login" label="Ingresar" />
<!--            <q-tab name="registro" label="Registrarse" />-->
          </q-tabs>
          <q-separator />
          <q-tab-panels v-model="tab" animated>
            <q-tab-panel name="login">
              <div class="text-h6">Ingresar al Sistema </div>
              Por favor colocar email y contraseña
              <q-form @submit.prevent="login">
                <div class="row">
                  <div class="col-12 ">
                    <q-input type="email" outlined v-model="email" label="Email*" hint="Porfavor ingresar email" :rules="rule">
                      <template v-slot:prepend>
                        <q-icon name="email" />
                      </template>
                    </q-input>
                  </div>
                  <div class="col-12 q-pt-md">
                    <q-input outlined v-model="password" label="password*" :type="isPwd ? 'password' : 'text'" hint="Porfavor ingresar password" :rules="rule">
                      <template v-slot:prepend>
                        <q-icon name="lock" />
                      </template>
                      <template v-slot:append>
                        <q-icon
                          :name="isPwd ? 'visibility_off' : 'visibility'"
                          class="cursor-pointer"
                          @click="isPwd = !isPwd"
                        />
                      </template>
                    </q-input>
                  </div>
                  <div class="col-12 q-py-md">
                    <q-btn label="INGRESAR" color="primary" icon="login" class="full-width" type="submit"/>
                    <div class="text-caption q-py-xs">
                      <a target="_blank" href="https://api.whatsapp.com/send?phone=59172354689&text=olvide mi contraseña">Olvidate tu contraseña?</a>
                    </div>

                  </div>
                </div>
              </q-form>
            </q-tab-panel>
<!--            <q-tab-panel name="registro">-->
<!--              <div class="text-h6">Registrate </div>-->
<!--              Registro unico para usuarios de la Gamo-->
<!--              <q-form @submit.prevent="registrar">-->
<!--                <div class="row">-->
<!--                  <div class="col-12">-->
<!--                    &lt;!&ndash;                    color="purple-12"&ndash;&gt;-->
<!--                    <q-input outlined type="email" v-model="user.email" label="Email*" hint="Porfavor ingresar email" :rules="rule" required>-->
<!--                      <template v-slot:prepend>-->
<!--                        <q-icon name="email" />-->
<!--                      </template>-->
<!--                    </q-input>-->
<!--                  </div>-->
<!--                  <div class="col-12 q-pt-md">-->
<!--                    <q-input outlined v-model="user.carnet" label="Carnet o NIT*" hint="Porfavor ingresar carnet o nit" :rules="rule">-->
<!--                      <template v-slot:prepend>-->
<!--                        <q-icon name="credit_card" />-->
<!--                      </template>-->
<!--                    </q-input>-->
<!--                  </div>-->
<!--                  <div class="col-12 q-pt-md">-->
<!--                    <q-input outlined v-model="user.name" label="Nombre completo*" hint="Porfavor ingresar nombre completo" :rules="rule">-->
<!--                      <template v-slot:prepend>-->
<!--                        <q-icon name="people" />-->
<!--                      </template>-->
<!--                    </q-input>-->
<!--                  </div>-->
<!--                  <div class="col-12 q-pt-md">-->
<!--                    <q-input outlined v-model="user.password" label="password*" :type="isPwd ? 'password' : 'text'" hint="Porfavor ingresar carnet de identidad" :rules="rule">-->
<!--                      <template v-slot:prepend>-->
<!--                        <q-icon name="lock" />-->
<!--                      </template>-->
<!--                      <template v-slot:append>-->
<!--                        <q-icon-->
<!--                          :name="isPwd ? 'visibility_off' : 'visibility'"-->
<!--                          class="cursor-pointer"-->
<!--                          @click="isPwd = !isPwd"-->
<!--                        />-->
<!--                      </template>-->
<!--                    </q-input>-->
<!--                  </div>-->
<!--                  <div class="col-12 q-pt-md">-->
<!--                    <q-select use-input @filter="filterFn" outlined v-model="user.unit" label="Unidad*" :options="units" option-label="nombre"  hint="Porfavor ingresar unidad"  >-->
<!--                      <template v-slot:prepend>-->
<!--                        <q-icon name="home" />-->
<!--                      </template>-->
<!--                    </q-select>-->
<!--                  </div>-->
<!--&lt;!&ndash;                  <div class="col-12">&ndash;&gt;-->
<!--&lt;!&ndash;                    <q-input outlined v-model="user.direccion" label="Direccion*" hint="Direccion de donde vives" :rules="rule">&ndash;&gt;-->
<!--&lt;!&ndash;                      <template v-slot:prepend>&ndash;&gt;-->
<!--&lt;!&ndash;                        <q-icon name="home" />&ndash;&gt;-->
<!--&lt;!&ndash;                      </template>&ndash;&gt;-->
<!--&lt;!&ndash;                    </q-input>&ndash;&gt;-->
<!--&lt;!&ndash;                  </div>&ndash;&gt;-->
<!--                  <div class="col-12 q-py-md">-->
<!--                    <q-btn label="Crea tu cuenta" color="primary" icon="login" class="full-width" type="submit"/>-->
<!--                    <q-btn label="Ingresa" color="secondary" icon="how_to_reg" @click="tab='login'" class="full-width q-mt-xs" />-->
<!--                    <div class="text-caption q-py-xs">-->
<!--                      <a target="_blank" href="https://api.whatsapp.com/send?phone=59169603027&text=olvide mi contraseña gamo">Olvidate tu contraseña?</a>-->
<!--                    </div>-->
<!--                  </div>-->
<!--                </div>-->
<!--              </q-form>-->
<!--            </q-tab-panel>-->
          </q-tab-panels>
        </q-card>
      </div>
      <div class="col-12 col-md-2">
      </div>
    </div>
  </q-page>
</template>

<script>

export default {
  data(){
    return{
      rule:[
        val => (val && val.length > 0) || 'Porfavor ingresar dato'
      ],
      email:'',
      password:'',
      tab:'login',
      user:{},
      isPwd:true,
      units:[],
      units2:[],
    }
  },
  created() {
    if (this.$store.getters["login/isLoggedIn"]){
      this.$router.push('/asignacion/todo')
    }

    this.$q.loading.show()
    this.$axios.get(process.env.API+'/unit').then(res=>{
      this.units=res.data
      this.units2=res.data
      // this.user.unit=res.data[0]
      this.$q.loading.hide()
    })

  },
  methods: {
    filterFn (val, update) {
      if (val === '') {
        update(() => {
          this.units = this.units2

          // here you have access to "ref" which
          // is the Vue reference of the QSelect
        })
        return
      }

      update(() => {
        const needle = val.toLowerCase()
        this.units = this.units2.filter(v => v.nombre.toLowerCase().indexOf(needle) > -1)
      })
    },
    registrar(){
      // console.log(this.user.unit_id)
      if (this.user.unit=='' || this.user.unit==undefined){
        this.$q.notify({
          message:'Debes seleccionar unidad',
          color:'red',
          icon:'error'
        })
        return false
      }
      this.$q.loading.show()
      this.user.unit_id=this.user.unit.id
      this.$store.dispatch('login/register', this.user).then(() =>{
        this.$q.loading.hide()
        this.$router.push('/asignacion/todo')
      })
        .catch(err => {
          this.$q.loading.hide();
          // console.log(err.response.data.errors)
          let text=''
          Object.entries(err.response.data.errors).forEach(([key, value]) => {
            // console.log(`${key} ${value}`);
            text+=' '+`${key}: ${value},`
          });
          this.$q.notify({
            message:text,
            color:'red',
            icon:'error'
          })
        })
    },
    login () {
      this.$q.loading.show()
      this.$store.dispatch('login/login', { email:this.email, password:this.password }).then(() =>{
        this.$q.loading.hide()
        this.$router.push('/asignacion/todo')
      })
        .catch(err => {
          this.$q.loading.hide();
          console.log(err.response.data.res)
          this.$q.notify({
            message:err.response.data.res,
            color:'red',
            icon:'error'
          })
        })
    },
  },
}

</script>

<style scoped>
</style>
