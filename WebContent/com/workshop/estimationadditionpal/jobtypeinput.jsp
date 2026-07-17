<%@page import="com.workshop.wsestimationpal.ClsWSEstimationPalDAO"%>
<%ClsWSEstimationPalDAO gatedao=new ClsWSEstimationPalDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
$(document).ready(function () {
    //console.log(window.jobtypedata);
    // prepare the data
    var jobtypedata='<%=gatedao.getJobTypeInputData(id)%>';
    
    var source =
    {
        datatype: "json",
        datafields: [
            	{name : 'doc_no', type: 'number'   },
				{name : 'date',type:'date'},
				{name : 'hrs',type:'number'},
				{name : 'rate',type:'number'},
				{name : 'jobtype',type:'string'},
				{name : 'jobtypeid',type:'string'},
				{name : 'jobdesc',type:'string'},
				{name : 'jobtypeanddesc',type:'string'},
        ],
        localdata: jobtypedata
    };
    var dataAdapter = new $.jqx.dataAdapter(source);
    // Create a jqxInput
    $("#jobtypeinput").jqxInput({ source: dataAdapter, placeHolder: "Job Type:", displayMember: "jobtype", valueMember: "doc_no", width: 250, height: 30});
    $("#jobtypeinput").on('select', function (event) {
        if (event.args) {
            var item = event.args.item;
            if (item) {
                for (var i = 0; i < dataAdapter.records.length; i++) {
                	if(item.label == dataAdapter.records[i].jobtype) {
                       //$('#jobdescription').val(dataAdapter.records[i].jobdesc);
                       $('#jobdescription').attr('data-jobtype',dataAdapter.records[i].jobtype);
                       $('#jobhrs').val(1);
                       $('#jobrate').val(0.0);
                       break;
                   }
               	}
            }
        }
    });

$('#jobtypeinput').on('keyup keypress', function(e) {
  var keyCode = e.keyCode || e.which;
  if (keyCode === 13) { 
    e.preventDefault();
    return false;
  }
});
});
function funAddJob(){
	if($('#mode').val()=='A' || $('#mode').val()=='E'){
		if($('#jobtypeinput').jqxInput('val')!=''){
			var labourrows=$('#labourcostGrid').jqxGrid('getrows');
			var labourindex=(labourrows.length)-1;
			$('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobtype',$('#jobdescription').attr('data-jobtype'));
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobdesc',$('#jobdescription').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobid',$('#jobtypeinput').jqxInput('val'));
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'hrs',$('#jobhrs').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'rate',$('#jobrate').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'remarks',$('#jobremarks').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'markuppercent',0.0);
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'seqno',labourrows.length);
	        $("#labourcostGrid").jqxGrid("addrow", null, {});
	        var hrs=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',labourindex,'hrs'));
	        var rate=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',labourindex,'rate'));
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'total',hrs*rate);
			$("#jobtypeinput").jqxInput('val', '');
			$('#jobdescription,#jobrate,#jobhrs,#jobremarks').val('');
			$('#jobdescription').attr('data-jobtype','');	
			$('#jobtypeinput').jqxInput('focus'); 	
		}
	}
}
</script>
<input id="jobtypeinput" />