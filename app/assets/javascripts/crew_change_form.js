$(function()
{
  function update_crew_change_form()
  {
    var action = $('#crew_change_action').val();

    if( action == 'Out' )
    {
      $('#crew_change_rate').attr('disabled', 'disabled');
      $('#crew_change_position_id').attr('disabled', 'disabled');
    }
    else
    {
      $('#crew_change_rate').removeAttr('disabled');
      $('#crew_change_position_id').removeAttr('disabled');
    }
  }

  $('#crew_change_action').change(function(event)
  {
    update_crew_change_form();
  });

  update_crew_change_form();

});
