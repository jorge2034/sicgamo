<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UnitSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('units')->insert([
//            ['nombre'=>'CATASTRO URBANO','codigo'=>'CAT'],
//            ['nombre'=>'CENTRO IMAGENOLOGIA','codigo'=>'IMA'],
//            ['nombre'=>'INDUSTRIA Y COMERCIO','codigo'=>'IND'],
//            ['nombre'=>'ESPECTACULOS PUBLICOS','codigo'=>'ESP'],
//            ['nombre'=>'CONTROL MERCADOS','codigo'=>'MER'],
//            ['nombre'=>'REGULACION URBANA','codigo'=>'REG'],
//            ['nombre'=>'CEMENTERIO GENERAL','codigo'=>'CEM'],
//            ['nombre'=>'REGULACION URBANA DISTRITO 3','codigo'=>'DIS'],
//            ['nombre'=>'ARBITRIOS MUNICIPALES','codigo'=>'ARB'],
//            ['nombre'=>'UNIDAD VALORES','codigo'=>'VAL'],
//            ['nombre'=>'DIRECCION TRAFICO y VIALIDAD','codigo'=>'TRA'],
//            ['nombre'=>'COACTIVA','codigo'=>'COA'],
//            ['nombre'=>'DIRECCION CASA MUNICIPAL DE CULTURA','codigo'=>'MUN'],
//            ['nombre'=>'DIRECCION PP SALUD','codigo'=>'SAL'],
//            ['nombre'=>'REGISTRO UNICO AUTOMOTOR','codigo'=>'AUT'],
//            ['nombre'=>'UNIDAD SISTEMA','codigo'=>'SIS'],
//            ['nombre'=>'ALCALDE MUNICIPAL','codigo'=>'ALMU'],
//            ['nombre'=>'SUB ALCALDIA D-3','codigo'=>'SUBALD3'],
            ['nombre'=>'SECRETARIA GENERAL','codigo'=>'SG'],
            ['nombre'=>'SECRETARIA MPAL. DE ECON.Y HACIENDA','codigo'=>'SEH'],
            ['nombre'=>'SECRETARIA MPAL. DE INFRAESTRUCTURA. PUBLICA','codigo'=>'SIP'],
            ['nombre'=>'SECRETARIA MPAL. DE GESTION TERRITORIAL','codigo'=>'SGT'],
            ['nombre'=>'SECRETARIA MPAL. DE CULTURA','codigo'=>'SCL'],
            ['nombre'=>'SECRETARIA MPAL. DE DESRROLLO HUMANO','codigo'=>'SDH'],
            ['nombre'=>'DIRECCION DE ASUNTOS JURIDICOS','codigo'=>'DAJ'],
            ['nombre'=>'DIRECCION DE DESARROLLO ORGANIZACIONAL','codigo'=>'DDO'],
            ['nombre'=>'DIRECCION RECURSOS HUMANOS','codigo'=>'DRH'],
            ['nombre'=>'DIRECCION COMUNICACION','codigo'=>'DCO'],
            ['nombre'=>'DIRECCION PLANIFICACION INTEGRAL','codigo'=>'DPI'],
            ['nombre'=>'DIRECCION TRIBUTARIA Y RECAUDACIONES','codigo'=>'DTI'],
            ['nombre'=>'DIRECCION TESORO','codigo'=>'DTE'],
            ['nombre'=>'DIRECCION OBRAS Y DESARROLLO URBANO','codigo'=>'DDU'],
            ['nombre'=>'DIRECCION DESARROLLO SOCIAL','codigo'=>'DDS'],
            ['nombre'=>'DIRECCION D.I.E.S.D.','codigo'=>'DID'],
            ['nombre'=>'DIRECCION EJECUTORA DE ASFALTO','codigo'=>'DEA'],
            ['nombre'=>'DIRECCION MOV. URBANA TRAFICO Y VIALIDAD','codigo'=>'DTV'],
            ['nombre'=>'DIRECCION ORDENAMIENTO TERRITORIAL','codigo'=>'DOT'],
            ['nombre'=>'DIRECCION DESARROLLO ECONOMICO SOCIAL','codigo'=>'DES'],
            ['nombre'=>'DIRECCION GESTION AMBIENTAL','codigo'=>'DGA'],
            ['nombre'=>'DIRECCION DE IGUALDAD DE OPORTUNIDADES','codigo'=>'DIO'],
            ['nombre'=>'DIRECCION PATRIMONIO Y TURISMO','codigo'=>'DPT'],
            ['nombre'=>'UNIDAD DE SISTEMAS','codigo'=>'USI'],
            ['nombre'=>'UNIDAD DE CONTABILIDAD','codigo'=>'UCT'],
            ['nombre'=>'UNIDAD DE TRANSPARENCIA','codigo'=>'UTR'],
            ['nombre'=>'UNIDAD DE TESORERIA','codigo'=>'UTE'],
            ['nombre'=>'UNIDAD CONTROL URBANO','codigo'=>'UCU'],
            ['nombre'=>'UNIDAD PAISAJISMO Y FORESTACION','codigo'=>'UPF'],
            ['nombre'=>'UNIDAD DE SALUD','codigo'=>'USA'],
            ['nombre'=>'UNIDAD DE PRESUPUESTOS','codigo'=>'UPR'],
            ['nombre'=>'UNIDAD BIENES Y SERVICIOS','codigo'=>'UBS'],
            ['nombre'=>'UNIDAD ADQUISICIONES','codigo'=>'UAD'],
            ['nombre'=>'UNIDAD CATASTRO URBANO','codigo'=>'UCA'],
            ['nombre'=>'UNIDAD DE EDUCACION','codigo'=>'UED'],
            ['nombre'=>'UNIDAD SEGURIDAD CIUDADANA','codigo'=>'USC'],
            ['nombre'=>'UNIDAD DEFENSA AL CONSUMIDOR','codigo'=>'UDC'],
            ['nombre'=>'UNIDAD FISCALIZACION','codigo'=>'UFS'],
            ['nombre'=>'UNIDAD GESTION DE PROYECTOS','codigo'=>'UGP'],
            ['nombre'=>'UNIDAD MANTENIMIENTO DE VIAS','codigo'=>'UMV'],
            ['nombre'=>'UNIDAD P.A.N.','codigo'=>'UPN'],
            ['nombre'=>'UNIDAD MERCADOS','codigo'=>'UME'],
            ['nombre'=>'UNIDAD DRENAJE URBANO','codigo'=>'UDU'],
            ['nombre'=>'UNIDAD FISCALIZACION DE OBRAS','codigo'=>'UFO'],
            ['nombre'=>'UNIDAD PREVENCION DE RIESGOS','codigo'=>'UPR'],
            ['nombre'=>'UNIDAD PROM.ACT.FISICA Y DEPORTIVA','codigo'=>'UFD'],
            ['nombre'=>'ADM.PARQUE ECOLOGICO','codigo'=>'APE'],
            ['nombre'=>'ADM.PARQUE INTI RAYMI','codigo'=>'API'],
            ['nombre'=>'ADM.AGUAS DANZANTES','codigo'=>'AAD'],
            ['nombre'=>'ADM.BALNEARIO CAPACHOS','codigo'=>'ABC'],
            ['nombre'=>'ADM.SALON LUIS RAMIRO BELTRAN','codigo'=>'ASB'],
            ['nombre'=>'ADM.MONUMENTO A LA VIRGEN','codigo'=>'AMV'],
            ['nombre'=>'ADM.CASA DE LA CULTURA','codigo'=>'ACC'],
            ['nombre'=>'ADM.ZOOLOGICO','codigo'=>'AZO'],
            ['nombre'=>'ADM.ZOONOSIS','codigo'=>'AZN'],
            ['nombre'=>'ADM.PISINA OLIMPICA','codigo'=>'APO'],
            ['nombre'=>'ADM.MUSEO ILDEFONSO MURGUIA','codigo'=>'AMM'],
            ['nombre'=>'RESPONSABLE SEGURO UNIVERSAL DE SALUD','codigo'=>'RSU'],
            ['nombre'=>'JEFATURA CONTROL AMBIENTAL','codigo'=>'JCA'],
            ['nombre'=>'RESP.TALLER TEXTIL','codigo'=>'RTT'],
            ['nombre'=>'UNID.ALUMBRADO PUBLICO','codigo'=>'UAP'],
            ['nombre'=>'UNID.ARCHIVO CENTRAL','codigo'=>'UAC'],
        ]);
    }
}
