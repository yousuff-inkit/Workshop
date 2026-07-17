<%@page import="com.workshop.wsjobcardpal.*" %>
<%ClsWSJobCardDAO jobdao=new ClsWSJobCardDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String refno=request.getParameter("refno")==null?"":request.getParameter("refno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String accno=request.getParameter("accno")==null?"":request.getParameter("accno");
String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype");
String reg=request.getParameter("regno")==null?"":request.getParameter("regno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<%-- <jsp:include page="../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript"> 

var searchdata=[];
var id='<%=id%>';
if(id=="1"){
	searchdata='<%=jobdao.getSearchData(refno,date,docno,reftype,id,cldocno,accno,reg,brhid)%>';
}
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             

                             
                            {name : 'doc_no', type: 'String'   },
                            {name : 'voc_no',type:'string'},
                            {name : 'account',type:'string'},
     						{name : 'refno', type: 'string'   },
     						{name : 'date',type:'date'},
     						{name : 'reftype', type: 'string'   },
     						{name : 'refvocno',type:'string'},
     						{name : 'userdetails', type: 'string'  },
     						{name : 'vehicledetails',type:'string'},
     						{name : 'regno',type:'string'},
     						{name : 'cldocno',type:'string'},
     						{name : 'refname',type:'string'},
							{name : 'estdocno',type:'string'},
     						{name : 'gipdocno',type:'string'},
     						{name : 'promdate',type:'date'},
     						{name : 'promtime',type:'string'},
     						
     						{name : 'jobdesc',type:'string'},
     						
                        ],
                		 localdata: searchdata, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#masterSearchGrid").jqxGrid(
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
                            { text: 'Doc No',  hidden:false, datafield: 'voc_no', width: '10%' },
                            { text: 'Doc No Original',  hidden:true, datafield: 'doc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Ref Type',datafield:'reftype',width:'10%'},
							{ text: 'Ref No',datafield:'refno',width:'10%',hidden:true},
							{ text: 'Ref No',datafield:'refvocno',width:'10%'},
							{ text : 'Regno',datafield:'regno',width:'10%'},
							{ text: 'Client Doc No', datafield: 'cldocno', width: '10%' },
							{ text: 'Account No', datafield: 'account', width: '10%' },
							{ text: 'Client Name', datafield: 'refname', width: '45%' },
							{ text: 'User Details',datafield:'userdetails',hidden:true},
							{ text:'vehicle details',datafield:'vehicledetails',hidden:true},
							{ text: 'prom Date', datafield: 'promdate', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true },
							{ text: 'promtime',datafield:'promtime',width:'10%',hidden:true},
							{ text: 'estdocno',datafield:'estdocno',width:'10%',hidden:true},
							{ text: 'gipdocno',datafield:'gipdocno',width:'10%',hidden:true},
							
							{ text: 'Job Desc',datafield:'jobdesc',width:'10%',hidden:true}
						]
            });
            
           $('#masterSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex = event.args.rowindex;
				 $('#lblgipno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "gipdocno"));
                $('#estdocno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "estdocno"));
                $('#refno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "refvocno"));
                $('#hidrefno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "refno"));
                $('#regno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "regno"));
                $('#vehicledetails').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "vehicledetails"));
                $('#userdetails').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "userdetails"));
                $('#cldocno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "cldocno"));
                $('#cmbreftype').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "reftype"));
                $('#docno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "doc_no"));
                $('#vocno').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "voc_no"));
                $('#date').jqxDateTimeInput('setDate',$('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "date"));
                $('#promdate').jqxDateTimeInput('setDate',$('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "promdate"));
              $('#promtime').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "promtime"));
                //$('#promtime').jqxDateTimeInput('setDate',$('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "promtime"));
                var reftype=$('#cmbreftype').val();
                
                $('#jobdesc').val($('#masterSearchGrid').jqxGrid('getcellvalue', rowindex, "jobdesc"));
                if(reftype=="EST"){
                	$('#sparediv').load('sparepartsGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
                	$('#labourdiv').load('labourcostGrid.jsp?docno='+$('#hidrefno').val()+'&id=1');
                	$('#labourcostGrid,#sparepartsGrid').jqxGrid({disabled:false});
                }
                
                $('#window').jqxWindow('close');
            });
        });
    </script>
    <div id="masterSearchGrid"></div>
 