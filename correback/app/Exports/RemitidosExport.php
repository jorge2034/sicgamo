<?php

namespace App\Exports;

use App\Models\Log;
use App\Models\Mail;
use Illuminate\Support\Facades\Date;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Events\BeforeExport;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use \Maatwebsite\Excel\Sheet;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Events\AfterSheet;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Style;
use PhpOffice\PhpSpreadsheet\Style\Color;
use Maatwebsite\Excel\Concerns\WithDefaultStyles;

class RemitidosExport implements FromQuery,WithMapping,WithHeadings,ShouldAutoSize,WithStyles,WithEvents,WithDefaultStyles
{
    use Exportable;
    private $rows = 0;
    public function forDate(string $fecha1,string $fecha2,int $idUnit)
    {
        $this->fecha1 = $fecha1;
        $this->fecha2 = $fecha2;
        $this->idUnit = $idUnit;

        return $this;
    }

    public function query()
    {
        return Mail::query()->where('unit_id', $this->idUnit)
        //->orWhere('user_id2',$request->user()->id)
        ->whereDate('fecha','>=',$this->fecha1)
        ->whereDate('fecha','<=',$this->fecha2);
       // ->with(['mail','user','unit','user2'])
    }
    public function map($mail): array
    {
        ++$this->rows;
        return [
            $this->rows,
           $mail->citecontrol,
           $mail->codigo,
            $mail->ref,
            $mail->folio,
           // Date::dateTimeToExcel($mail->fecha),
            $mail->fecha,
        ];
    }
    public function headings(): array
    {
        return [
            ['FONDO:','GOBIERNO AUTONOMO MUNICIPAL DE ORURO'],
            ['SEMIFONDO:','DIRECCION DE DESARROLLO ORGANIZACIONAL'],
            ['SECCIÓN:','UNIDAD DE SISTEMAS E INFORMACION'],
            ['SERIE DOCUM.:','CORRESPONDENCIA ENVIADA O EXPEDIDA'],
            ['Nro.',
            'CITE',
            'CODIGO',
            'REFERENCIA',
            'FS.',
            'AÑO',
            'SOP.',
            'CAJA',
            'UBICACION',
            'OBSERVACIONES']
        ];
    }

public function registerEvents(): array
{
    return [
        AfterSheet::class    => function(AfterSheet $event) {
            $cellRange = 'A5:J5'; // All headers
            $event->sheet->getDelegate()->getStyle($cellRange)->getFont()->setSize(14);
            $event->sheet->getDelegate()->getStyle($cellRange)->getFont()->getColor()
                         ->setARGB(\PhpOffice\PhpSpreadsheet\Style\Color::COLOR_WHITE);
            $event->sheet->getDelegate()->getStyle($cellRange)->getFill()
                         ->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)
                         ->getStartColor()->setARGB('FF17a2b8');
            $event->sheet->setAutoFilter($cellRange);
        },
    ];


}

public function defaultStyles(Style $defaultStyle)
{
    // Configure the default styles
    return $defaultStyle->getFill()->setFillType(Fill::FILL_SOLID);

    // Or return the styles array
    return [
        'fill' => [
            'fillType'   => Fill::FILL_SOLID,
            'startColor' => ['argb' => Color::COLOR_RED],
        ],
    ];
}
    public function startCell(): string
    {
        return 'A5';
    }
    public function styles(Worksheet $sheet)
    {

        $sheet->getStyle('A1')->getFont()->setBold(true);
        $sheet->getStyle('A2')->getFont()->setBold(true);
        $sheet->getStyle('A3')->getFont()->setBold(true);
        $sheet->getStyle('A4')->getFont()->setBold(true);
        return [
            // Style the first row as bold text.
            5 => ['font' => ['bold' => true,'size' => 14]],
        ];
    }
}
