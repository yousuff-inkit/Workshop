<%@page import="com.workshop.estimationv5.*"%>
<%ClsEstimationV5DAO gatedao=new ClsEstimationV5DAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
$(document).ready(function () {
    console.log(window.jobtypedata);
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
				{name : 'taxable',type:'string'},
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
					   	$('#jobdescription').attr('data-docno',dataAdapter.records[i].doc_no);
                       	$('#jobdescription').attr('data-jobtype',dataAdapter.records[i].jobtype);
                       	$('#jobdescription').attr('data-taxable',dataAdapter.records[i].taxable);
                       	$('#jobhrs').val(1);
                       	$('#jobrate').val(0.0);
                       	if(dataAdapter.records[i].taxable=="1"){
                       		$('#jobvatpercent').attr('readonly',true);
							$('#jobvatpercent').val(5);
                       	}
                       	else{
                       		$('#jobvatpercent').attr('readonly',false);
                       		$('#jobvatpercent').val(0);
                       	}
                       	if($('#rateconfig').val()=='1'){
                			$('#jobrate').val($('#wsserviceamt').val());       			
                       	}
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
			if(labourindex==-1){
				$("#labourcostGrid").jqxGrid("addrow", null, {});
				labourindex=0;
			}
			$('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobtype',$('#jobdescription').attr('data-jobtype'));
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobdesc',$('#jobdescription').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobid',$('#jobdescription').attr('data-docno'));
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'taxable',$('#jobdescription').attr('data-taxable'));
	        if($('#jobdescription').attr('data-taxable')=='0'){
	        	$('#cmbentitytype').val('0').trigger('change');
	        }
	        
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'hrs',$('#jobqty').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'rate',$('#jobrate').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'remarks',$('#jobremarks').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobqty',$('#jobqty').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobdiscount',$('#jobdiscount').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobvatpercent',$('#jobvatpercent').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobvatamount',$('#jobvatamount').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobnetamount',$('#jobnetamount').val());
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'markuppercent',0.0);
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'seqno',labourrows.length);
	        $("#labourcostGrid").jqxGrid("addrow", null, {});
	        var hrs=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',labourindex,'hrs'));
	        var rate=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',labourindex,'rate'));
			var jobqty=parseFloat($('#labourcostGrid').jqxGrid('getcellvalue',labourindex,'jobqty'));
			var discount=$('#labourcostGrid').jqxGrid('getcellvalue',labourindex,'jobdiscount');
			discount=(discount=="" || discount=="undefined" || typeof(discount)=="undefined" || discount==null?0.0:parseFloat(discount));
	        
	        $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'total',(hrs*rate)-discount);
			
			$("#jobtypeinput").jqxInput('val', '');
			$('#jobdescription,#jobrate,#jobhrs,#jobremarks,#jobqty,#jobdiscount,#jobvatamount,#jobnetamount,#jobamount').val('');
			$('#jobdescription').attr('data-jobtype','');	
			$('#jobdiscount').val(0);
			$('#jobtypeinput').jqxInput('focus'); 
			funSetDistJobDiscount();	
		}
	}
}
</script>
<input id="jobtypeinput" />