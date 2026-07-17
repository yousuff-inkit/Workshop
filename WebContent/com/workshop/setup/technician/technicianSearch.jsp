<%@page import="com.workshop.setup.technician.ClsTechnicianDAO" %>
<%ClsTechnicianDAO dao=new ClsTechnicianDAO();
String check=request.getParameter("id")==null?"0":request.getParameter("id");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
String desc=request.getParameter("desc")==null?"NA":request.getParameter("desc");
%>

<script type="text/javascript">
var check='<%=check%>';
var jobsrchdata;
if(check=="1"){
	jobsrchdata='<%=dao.loadSearchGrid()%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'doc_no' , type: 'string' },
                      	{name : 'date' , type: 'string' },
                      	{name : 'name' , type: 'string' },
                      	{name : 'acno' , type: 'string' },
                      	{name : 'email' , type: 'string' },
                      	{name : 'mobile' , type: 'string' },
                      	{name : 'stdcost' , type: 'string' },
                      	{name : 'acname' , type: 'string' },
                      	{name : 'accdocno' , type: 'string' },
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



        $("#technicianSearchGrid").jqxGrid(
                {
                	width: '100%',
                    height: 350,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  //  pagermode: 'default',
                    sortable: true,
                    //pageable: true,
                    altrows:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
						{ text: 'Doc_no',datafield: 'doc_no', width: '5%' ,hidden: true},
						{ text: 'Date',datafield: 'date', width: '12%' },
						{ text: 'Account No',datafield: 'acno', width: '12%' },
						{ text: 'Name',datafield: 'name' },
    					{ text: 'Mobile',datafield: 'mobile', width: '12%',hidden: false },
    					{ text: 'Account Name',datafield: 'acname', width: '7%',hidden: true },
    					{ text: 'Account Docno',datafield: 'accdocno', width: '7%',hidden: true },
    					{ text: 'Std cost',datafield: 'stdcost', width: '7%' },
						{ text: 'Email',datafield: 'email', width: '15%' },
    					

    	              ]
                });
        
        $("#technicianSearchGrid").on("rowdoubleclick", function (event) {
            var row1=event.args.rowindex;
			$('#docno').val($('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
			$('#accountname').val($('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'acname'));
			$('#accountno').val($('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'acno'));
			$('#email').val($('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'email'));
			var accuntdocno= $('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'accdocno');
			$('#hidaccdocno').val(accuntdocno);
			$('#actualstdcost').val($('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'stdcost'));
			$('#name').val($('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'name'));
			$('#mobile').val($('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'mobile'));
			$('#date').jqxDateTimeInput('setDate',$('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'date'));
			var docno=$('#technicianSearchGrid').jqxGrid('getcellvalue',row1,'doc_no');
			$('#jobmasterdiv').load('jobMasterGrid.jsp?id=1'+'&docno='+docno); 
			$('#window').jqxWindow('hide');
            });
        
        

	});
</script>
<div id="technicianSearchGrid"></div>