<%@page import="com.workshop.setup.jobmaster.ClsJobMasterDAO" %>
<%ClsJobMasterDAO dao=new ClsJobMasterDAO();
String check=request.getParameter("id")==null?"0":request.getParameter("id");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
String desc=request.getParameter("desc")==null?"NA":request.getParameter("desc");
%>

<script type="text/javascript">
var check='1';
var jobsrchdata;
if(check=="1"){
	jobsrchdata='<%=dao.loadgrid()%>';
}
function funJobOk(){
	var rows=$('#servicePackageGrid').jqxGrid('getrows');
	var selectedrows=$("#jobSearchGrid").jqxGrid('getselectedrowindexes');
	var rowindex=(rows.length)-1;
	for(var i=0;i<selectedrows.length;i++){
		$('#servicePackageGrid').jqxGrid('setcellvalue',rowindex,'jobdocno',$("#jobSearchGrid").jqxGrid('getcellvalue',selectedrows[i],'doc_no'));
		$('#servicePackageGrid').jqxGrid('setcellvalue',rowindex,'jobdate',$("#jobSearchGrid").jqxGrid('getcellvalue',selectedrows[i],'date'));
		$('#servicePackageGrid').jqxGrid('setcellvalue',rowindex,'jobtype',$("#jobSearchGrid").jqxGrid('getcellvalue',selectedrows[i],'type'));
		$('#servicePackageGrid').jqxGrid('setcellvalue',rowindex,'jobdesc',$("#jobSearchGrid").jqxGrid('getcellvalue',selectedrows[i],'desc'));
		rowindex++;
		$("#servicePackageGrid").jqxGrid('addrow', null, {});
	}
	$('#jobwindow').jqxWindow('close');
}
function funJobCancel(){
	$('#jobwindow').jqxWindow('close');
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [  
                      	{name : 'desc' , type: 'string' },
                      	{name : 'doc_no' , type: 'string' },
                      	{name : 'date' , type: 'string' },
                      	{name : 'type' , type: 'string' },
                      	{name : 'jobid' , type: 'string' },
                      	{name : 'stdrate' , type: 'string' },
                      	{name : 'stdcostperhr' , type: 'string' },
             ],
             localdata: jobsrchdata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#jobSearchGrid").jqxGrid(
                {
                	width: '100%',
                    height: 330,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'checkbox',
                  //  pagermode: 'default',
                    sortable: true,
                    //pageable: true,
                    altrows:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '8%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
						{ text: 'Doc_no',datafield: 'doc_no', width: '5%' },
						{ text: 'Date',datafield: 'date', width: '12%' },
						{ text: 'JobType',datafield: 'type', width: '14%' },
						{ text: 'STD HR',datafield: 'stdrate', width: '14%' },
						{ text: 'STD Rate/HR ',datafield: 'stdcostperhr', width: '14%' },
    					{ text: 'Description',datafield: 'desc' },
    					{ text: 'JobTypeid',datafield: 'jobid', width: '5%',hidden:true },

    	              ]
                });
        
/*         $("#jobSearchGrid").on("rowdoubleclick", function (event) {
            var row1=event.args.rowindex;
            $('#docno').attr('readonly', false);    
			$('#docno').val($('#jobSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
			$('#docno').attr('readonly', true);
			$('#hidcmbjobtype').val($('#jobSearchGrid').jqxGrid('getcellvalue',row1,'jobid'));
			$('#cmbjobtype').val($('#jobSearchGrid').jqxGrid('getcellvalue',row1,'jobid'));
			$('#description').val($('#jobSearchGrid').jqxGrid('getcellvalue',row1,'desc'));
			$('#stdhr').val($('#jobSearchGrid').jqxGrid('getcellvalue',row1,'stdrate'));
			$('#stdrateperhr').val($('#jobSearchGrid').jqxGrid('getcellvalue',row1,'stdcostperhr'));
			$('#date ').jqxDateTimeInput('setDate',$('#jobSearchGrid').jqxGrid('getcellvalue',row1,'date'));
			var docno=$('#jobSearchGrid').jqxGrid('getcellvalue',row1,'doc_no');
			$('#jobdescdiv').load('jobDescGrid.jsp?id=1'+'&docno='+docno); 
			 $('#jobwindow').jqxWindow('hide');
            });
 */
	});
	
	
	
</script>
<table style="width:100%;">
  <tr>
    <td align="center"><input type="button" name="btnjobcancel" id="btnjobcancel" value="Cancel" onclick="funJobCancel();">&nbsp;&nbsp;<input type="button" name="btnjobok" id="btnjobok" value="OK"  onclick="funJobOk();"></td>
  </tr>
  <tr>
    <td><div id="jobSearchGrid"></div></td>
  </tr>
</table>

