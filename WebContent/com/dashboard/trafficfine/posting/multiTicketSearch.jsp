<%@page import="com.dashboard.trafficfine.posting.ClsPostingDAO" %>
<%ClsPostingDAO postdao=new ClsPostingDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String type=request.getParameter("type")==null?"":request.getParameter("type");
String acno=request.getParameter("acno")==null?"":request.getParameter("acno");
String ticketno=request.getParameter("ticketno")==null?"":request.getParameter("ticketno");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
%>
<script type="text/javascript">
		 var multidata=null;
		 var id='<%=id%>';
		 if(id=="1"){
			multidata='<%=postdao.getMultiTickets(branch,fromdate,todate,type,acno,id,ticketno,regno)%>';
			
		 }
        $(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'source', type: 'int' },
     						{name : 'ticket_no', type: 'string' }, 
     						{name : 'traffic_date', type: 'date'   },
     						{name : 'amount', type: 'number'  },
     						{name : 'regno',type:'number'}
                        ],
                         localdata: multidata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };

        	$("#multiTicketSearch").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            	
            	});
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#multiTicketSearch").jqxGrid(
            {
                width: '98%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'checkbox',
               
                columns: [
							{ text: 'Sr No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Ticket No', datafield: 'ticket_no', width: '22.75%' },
							{ text: 'Reg No',  datafield: 'regno',  width: '22.75%'},
                            { text: 'Traffic Date',datafield:'traffic_date',width:'22.75%',cellsformat:'dd.MM.yyyy'},
                            { text: 'Amount',datafield:'amount',cellsformat:'d2'}
							
						]
            });
           
        });

</script>
<div id="multiTicketSearch"></div>