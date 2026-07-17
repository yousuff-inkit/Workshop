<%@page import="com.dashboard.workshop.jobclockin.*" %>
<% ClsJobClockinDAO DAO=new ClsJobClockinDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String date = request.getParameter("date")==null?"":request.getParameter("date");
 String id = request.getParameter("check")==null?"0":request.getParameter("check");
 String status = request.getParameter("status")==null?"0":request.getParameter("status");
 String jobnos = request.getParameter("jobnos")==null?"":request.getParameter("jobnos");
 %>
 
<script type="text/javascript">
        
		var id='<%=id%>';
		var status='<%=status%>';
		var data4;
		if(id=='1'){
			 data4= '<%=DAO.jobCardData(date,id,jobnos)%>';
		}else{
			data4=[];
		}
		
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'voc_no', type: 'String'}, 
							{name : 'doc_no', type: 'String'},
     						{name : 'date', type: 'string'},
     						{name : 'reftype', type: 'string'}
                        ],
                		 localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
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
							{ text: 'Job Card No',  datafield: 'voc_no', width: '30%' },
							{ text: 'Doc No',  datafield: 'doc_no', width: '30%',hidden:true },
							{ text: 'Date',datafield:'date',width:'30%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Ref Type',  datafield: 'reftype', width: '35%' },
						]
            });
            
             $('#jcSearchGrid').on('rowdoubleclick', function (event) {
            	var techindex=$('#techindex').val();
            	var rowindex1=event.args.rowindex;
            	if(status==1){
            		document.getElementById("txtjobcard").value =$('#jcSearchGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
            		document.getElementById("txtjobcardvoc").value =$('#jcSearchGrid').jqxGrid('getcellvalue',rowindex1,'voc_no');
            	}
            	if(status==2){
             		document.getElementById("jobcard").value =$('#jcSearchGrid').jqxGrid('getcellvalue',rowindex1,'doc_no');
             	    document.getElementById("jobcardvoc").value =$('#jcSearchGrid').jqxGrid('getcellvalue',rowindex1,'voc_no'); 
            	}
            	$('#jobCardToWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="jcSearchGrid"></div>