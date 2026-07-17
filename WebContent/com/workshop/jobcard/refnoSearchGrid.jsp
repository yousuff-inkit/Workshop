<%@page import="com.workshop.wsjobcard.*" %>
<%ClsWSJobCardDAO jobdao=new ClsWSJobCardDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String refgatevocno=request.getParameter("refgatevocno")==null?"":request.getParameter("refgatevocno");
String refestvocno=request.getParameter("refestvocno")==null?"":request.getParameter("refestvocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String refdate=request.getParameter("refdate")==null?"":request.getParameter("refdate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype");
%>
<%-- 
refgatevocno='+refgatevocno+'&refestvocno='+refestvocno+'&clientname='+clientname+'&
regno='+regno+'&refdate='+refdate+'&id=1&branch='+branch+'&reftype='+reftype
<jsp:include page="../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">

var refdata=[];
var id='<%=id%>';
var reftype='<%=reftype%>';
if(id=="1"){
	refdata='<%=jobdao.getRefData(refgatevocno,refestvocno,clientname,regno,refdate,branch,reftype,id)%>';
}
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             

                             
                            {name : 'gatevocno', type: 'String'   },
                            {name : 'gatedocno',type:'string'},
                            {name : 'estvocno',type:'string'},
                            {name : 'estdocno',type:'string'},
     						{name : 'refdate', type: 'date'   },
     						{name : 'cldocno', type: 'string'   },
     						{name : 'userdetails', type: 'string'  },
     						{name : 'vehicledetails',type:'string'},
     						{name : 'regno',type:'string'},
     						{name : 'refname',type:'string'}
     						
                        ],
                		 localdata: refdata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#refSearchGrid").jqxGrid(
            {
            	width: '100%',
                height: 300,
                columnsheight:23,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                sortable:false,
                
                columns: [
                          
							{ text: 'SI No', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }
							},
							{ text: 'GIP No',  hidden:false, datafield: 'gatevocno', width: '10%' },
                            { text: 'GIP No',  hidden:true, datafield: 'gatedocno', width: '10%' },
                            { text: 'Est No',  hidden:false, datafield: 'estvocno', width: '10%' },
                            { text: 'Est No',  hidden:true, datafield: 'estdocno', width: '10%' },
                            { text: 'Regno',datafield:'regno',width:'10%'},
                            { text: 'Date', datafield: 'refdate', width: '15%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Client Doc No', datafield: 'cldocno', width: '15%',hidden:true },
							{ text: 'Client Name', datafield: 'refname', width: '50%'},
							{ text: 'User Details',datafield:'userdetails',hidden:true},
							{ text:'vehicle details',datafield:'vehicledetails',hidden:true},
							
							
						]
            });
            
           $('#refSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex = event.args.rowindex;
                if(reftype=="GIP"){
                	$('#refno').val($('#refSearchGrid').jqxGrid('getcellvalue', rowindex, "gatevocno"));
                    $('#hidrefno').val($('#refSearchGrid').jqxGrid('getcellvalue', rowindex, "gatedocno"));
                }
                else{
                	$('#refno').val($('#refSearchGrid').jqxGrid('getcellvalue', rowindex, "estvocno"));
                    $('#hidrefno').val($('#refSearchGrid').jqxGrid('getcellvalue', rowindex, "estdocno"));
                }
                $('#regno').val($('#refSearchGrid').jqxGrid('getcellvalue', rowindex, "regno"));
                $('#vehicledetails').val($('#refSearchGrid').jqxGrid('getcellvalue', rowindex, "vehicledetails"));
                $('#userdetails').val($('#refSearchGrid').jqxGrid('getcellvalue', rowindex, "userdetails"));
                $('#cldocno').val($('#refSearchGrid').jqxGrid('getcellvalue', rowindex, "refname"));
                if(reftype=="EST"){
                	$('#sparediv').load('sparepartsGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
                	$('#labourdiv').load('labourcostGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
                	$('#labourcostGrid,#sparepartsGrid').jqxGrid({disabled:false});
                }
                $('#searchwindow').jqxWindow('close');
            });
        });
    </script>
    <div id="refSearchGrid"></div>
 