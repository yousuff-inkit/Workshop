<%@page import="com.dashboard.workshop.estimationlist.ClsEstimationListDAO"%>
<%
String brach=request.getParameter("brach")==null?"":request.getParameter("brach");
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("tdt")==null?"0":request.getParameter("tdt").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
String type =request.getParameter("ldtype")==null?"0":request.getParameter("ldtype");
String client =request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
//System.out.println("client------------------"+client);
ClsEstimationListDAO DAO= new ClsEstimationListDAO();
%>
	   

 <script type="text/javascript">    
 var data1;  
 var exceldata;
 var chk='<%=check%>';
 	if(chk!='NN'){ 
 		data1='<%=DAO.masterdetails(brach,fromdate,todate,check,client)%>';
 		<%-- exceldata='<%=DAO.masterexceldetails(branch,fromdate,cldocno,check,process,salid)%>'; --%>
 		
        }
 	else
 	{
 		
 		data1;
 		clientexceldata;
 		//alert(clientexceldata);
 	}
    
 	$(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'doc_no',type:'number'},
              		{name : 'date',type:'date'},
              		{name : 'estvocno',type:'number'},
              		{name : 'gatevocno',type:'number'},
              		{name : 'refname',type:'string'},
              		{name : 'vehno',type:'string'},
              		{name : 'vehicledetails',type:'string'},
              		{name : 'kmin',type:'string'},
              		{name : 'jobdesc',type:'String'},
              		{name : 'nettotal',type:'number'},
              		{name : 'brhid',type:'string'},
              		{name : 'gipno',type:'number'},
              		{name : 'vehno',type:'string'},
              		{name : 'voc_no',type:'number'},
              		{name : 'branchname',type:'string'},
              		{name : 'gateinpassdocno',type:'string'},


                   						
                   				//	 t.postdocno
                   						
                   					// rano dtypedesc
                   						
                   						
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
          
            $("#estimationlistGrid").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showfilterrow: true,
                columnsresize: true,
                showaggregates:true,
                enabletooltips:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
                	{ text: 'Sr. No', sortable: false, filterable: true, editable: false,
                        groupable: false, draggable: false, resizable: false,datafield: '',
                        columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                        cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      					}    
                  				},
                  				{ text: 'Branch Name',datafield:'branchname',width:'10%'},
                  				{ text: 'Doc No',datafield:'estvocno',width:'9%'},
                  				{ text: 'Date',datafield:'date',width:'9%',cellsformat:'dd.MM.yyyy'},
                  				{ text: 'GIP No',datafield:'gatevocno',width:'9%'},
                  				{ text: 'Client', datafield:'refname',width:'20%'},
                  				{ text: 'Vehicle Number', datafield:'vehno',width:'10%'},
                  				{ text: 'Vehicle Details',datafield:'vehicledetails',width:'20%'},
                  				{ text: 'KM',datafield:'kmin',cellsalign: "right",  width: '7%' },
                  				{ text: 'Job Description', datafield:'jobdesc',width:'20%'},
                  				{ text: 'Net Total',datafield:'nettotal',width:'10%',align:'right',cellsalign:'right',cellsformat:'d2'},
                   				{ text: 'Brhid', datafield:'brhid',hidden:true},
                  				{ text: 'gipno', datafield:'gipno',hidden:true},
                  				{ text: 'doc_no', datafield:'doc_no',hidden:true},
                  				{ text: 'gateinpassdocno', datafield:'gateinpassdocno',hidden:true},
                  				{ text: 'jcno', datafield:'voc_no',hidden:true}
]
								 
            });
            $("#overlay, #PleaseWait").hide();
            
            $('#estimationlistGrid').on('rowdoubleclick', function (event) 
              		{ 
          	  var rowindex1=event.args.rowindex;
          	    document.getElementById("estDocno").value = $('#estimationlistGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
	  			document.getElementById("brhid").value = $('#estimationlistGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
	  			document.getElementById("gipnos").value = $('#estimationlistGrid').jqxGrid('getcellvalue', rowindex1, "gipno");
	  		    document.getElementById("estvocno").value = $('#estimationlistGrid').jqxGrid('getcellvalue', rowindex1, "estvocno");
	  		    document.getElementById("gipdocno").value = $('#estimationlistGrid').jqxGrid('getcellvalue', rowindex1, "gateinpassdocno");
	  		    document.getElementById("gatevocno").value = $('#estimationlistGrid').jqxGrid('getcellvalue', rowindex1, "gatevocno");
	  		   
              });	 
            
        });
 	
    </script>
    <div id="estimationlistGrid" ></div>


