/**
 * Created by aldrin on 11/20/15.
 */

function addEquipment(){
    var additionalEquipmentDiv = $('#additional-equipment-div div:last');
    var $divClone = additionalEquipmentDiv.clone();

    var $textBox = $divClone.children('input:text');
    $textBox.prop('value', '');
    var textName = $textBox.prop('name');
    var index = textName.substring(textName.indexOf('[') + 1, textName.indexOf(']'));
    textName = textName.replace(index, (parseInt(index) + 1).toString());
    $textBox.prop('name', textName);
    additionalEquipmentDiv.after($divClone);
}

function removeEquipment(tableRowId){
    $("#" + tableRowId).remove();
}