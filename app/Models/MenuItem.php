<?php


namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class MenuItem extends Model
{
    public function parent()
    {
        return $this->belongsTo(MenuItem::class, 'id', 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(MenuItem::class,'parent_id', 'id');
    }
}
