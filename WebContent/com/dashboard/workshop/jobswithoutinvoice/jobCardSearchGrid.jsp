<%@page import="com.dashboard.workshop.jobswithoutinvoice.*" %>
<% ClsJobsWithoutInvoiceDAO DAO=new ClsJobsWithoutInvoiceDAO(); %>

 <%
 String jobcardno = request.getParameter("jobcardno")==null?"":request.getParameter("jobcardno");
 String jobcarddate = request.getParameter("jobcarddate")==null?"":request.getParameter("jobcarddate");
 String estdocno = request.getParameter("estdocno")==null?"":request.getParameter("estdocno");
 String gipdocno = request.getParameter("gipdocno")==null?"":request.getParameter("gipdocno");
 String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
 String clientname = request.getParameter("clientname")==null?"":request.getParameter("clientname");
 String id = request.getParameter("id")==null?"":request.getParameter("id");
 %>
<script type="text/javascript">
        
		var id='<%=id%>';
		var searchjobsdata;
		if(id=='1'){
			 searchjobsdata= '<%=DAO.getSearchJobCard(jobcardno,jobcarddate,estdocno,gipdocno,cldocno,clientname,id)%>';
		}else{
			searchjobsdata=[];
		}
		
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'voc_no', type: 'number'},
     						{name : 'date', type: 'date'},
     						{name : 'reftype', type: 'string'},
     						{name : 'estvocno',type:'number'},
     						{name : 'gipvocno',type:'number'},
     						{name : 'cldocno',type:'number'},
     						{name : 'refname',type:'string'}
     						
                        ],
                		 localdata: searchjobsdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            $("#jcSearchGrid").on("bindingcomplete", function (event) {$("#overlay, #PleaseWait").hide(); });  
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jcSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							     return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							  					}    
											},
							{ text: 'Doc No',  datafield: 'voc_no', width: '8%' },
							{ text: 'Date',datafield:'date',width:'10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Ref Type',  datafield: 'reftype', width: '8%' },
							{ text: 'Est No',  datafield: 'estvocno', width: '8%' },
							{ text: 'GIP No',  datafield: 'gipvocno', width: '8%' },
							{ text: 'Client No',  datafield: 'cldocno', width: '8%' },
							{ text: 'Name',  datafield: 'refname', width: '45%' }
						]
            });
            
             $('#jcSearchGrid').on('rowdoubleclick', function (event) {
            	//var techindex=$('#techindex').val();
            	var rowindex1=event.args.rowindex;
             	document.getElementById("jobcard").value =$('#jcSearchGrid').jqxGrid('getcellvalue',rowindex1,'voc_no');
             	document.getElementById("hidjobcard").value =$('#jcSearchGrid').jqxGrid('getcellvalue',rowindex1,'voc_no');
            	$('#jobcardwindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="jcSearchGrid"></div>