$(document).ready(function() {
	$(".delete_record").click(function() {
		$("#myModal").modal("show");
	});

	$('#myModal').on('show.bs.modal', function(e) {
	});
	$(".edit_record").click(function() {
		$("#myModal1").modal("show");
	});
	
});
function confirm_modal(delete_url, reload_url) {
	// alert(var1);
	jQuery('#myModal').modal('show', {
		backdrop : 'static'
	});
	document.getElementById('delete_btn').setAttribute("onclick",
			"modal_delete('" + delete_url + "','" + reload_url + "')");
}
function modal_delete(delete_url, reload_url) {
	document.getElementById('delete_form').setAttribute("action",delete_url);
	document.getElementById('delete_form').submit();

}

function edit_modal(edit_url, update_url, reload_url) {

	$.ajax({
		url : edit_url,
		success : function(result) {
			// alert(jQuery('#edit_modal').find(".modal-body").html());
			jQuery('#edit_modal').find(".modal-body").html(result);

			jQuery('#edit_modal').modal('show', {
				backdrop : 'static'
			});
			document.getElementById('cartype_frm').setAttribute("action",
					update_url);
			jQuery('#cartypefrm').find("#cartype-update-btn").attr('value',
					'Update');
			
			$("#cartype_frm").submit(function(e){
				var cartype_frm=$(this);
				e.preventDefault();
				$.ajax({
					url : update_url,
					method: "POST",
					data: $('#cartype_frm').serialize(),
					success : function(result) {
						if(result.STATUS ==="success")
						{
							$(location).attr('href', reload_url);
						}
						else if(result.STATUS ==="error")
						{
							var errors=result.VALUE;
							 $.each(errors, function(key, value) {				 
								 cartype_frm.find("#"+key+"-error").text(value).css("display","inline-block");
								  //console.log(key+" "+value)
							});
						}
						//jQuery('#edit_modal').find(".modal-body").html(result);
					}
				});
			});
		}	
	});
}
function modal_edit(update_url, reload_url) {
	console.log(delete_url)
}

function add_modal(add_url) {
	$.ajax({
		url : add_url,
		success : function(result) {
			// alert(jQuery('#edit_modal').find(".modal-body").html());
			jQuery('#edit_modal').find(".modal-body").html(result);

			jQuery('#edit_modal').modal('show', {
				backdrop : 'static'
			});
			document.getElementById('cartype_frm').setAttribute("action",
					"/CRMS/cartype/save");
			jQuery('#cartypefrm').find("#cartype-update-btn").attr('value',
					'Save');
			
			$("#cartype_frm").submit(function(e){
				var cartype_frm=$(this);
				e.preventDefault();
				$.ajax({
					url : "/CRMS/cartype/save",
					method: "POST",
					data: $('#cartype_frm').serialize(),
					success : function(result) {
						if(result.STATUS ==="success")
						{
							location.reload();
						}
						else if(result.STATUS ==="error")
						{
							var errors=result.VALUE;
							 $.each(errors, function(key, value) {				 
								 cartype_frm.find("#"+key+"-error").text(value).css("display","inline-block");
								  //console.log(key+" "+value)
							});
						}
						//jQuery('#edit_modal').find(".modal-body").html(result);
					}
				});
			});
		}	
	});
}
function modal_edit(update_url, reload_url) {
	console.log(delete_url)
}