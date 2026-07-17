<%@page import="com.dashboard.workshop.gateinpassanalysis.*"%>
<%
ClsGateInPassAnalysisDAO DAO= new ClsGateInPassAnalysisDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
  
  var id='<%=id%>';
  var gipdata;
  if(id=="1"){
	  gipdata='<%=DAO.getGIPData(id)%>';
  }
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'number'  },
                            {name : 'voc_no', type: 'number'  },
                            {name : 'date', type: 'date'},
                            {name : 'regno',type:'number'},
                            {name : 'pltid',type:'string'}
                        ],
                 	localdata: gipdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#gipSearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc No', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Doc No', datafield: 'voc_no', width: '25%' },
                              { text: 'Date', datafield: 'date', width: '25%',cellsformat:'dd.MM.yyyy' },
                              { text: 'Reg No',datafield: 'regno',width: '25%'},
                              { text: 'Plate Code',datafield: 'pltid',width:'25%'}
						]
            });
            
          $('#gipSearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("gipvocno").value=$('#gipSearch').jqxGrid('getcellvalue', rowindex2, "voc_no");
                document.getElementById("gipdocno").value=$('#gipSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                document.getElementById("regno").value=$('#gipSearch').jqxGrid('getcellvalue', rowindex2, "regno");
                $('#gipwindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="gipSearch"></div>