<%@page import="com.dashboard.workshop.gipmatrequest.*" %>
<%ClsGIPMatRequestDAO reqdao=new ClsGIPMatRequestDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String mode=request.getParameter("mode")==null?"":request.getParameter("mode");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>

<script type="text/javascript">   
var id='<%=id%>';
var gipdata=[];
if(id=="1"){
	gipdata='<%=reqdao.getGIPData(id,mode,brhid)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'gatedocno' , type: 'number'},
 						{name : 'gatevocno', type: 'number'},
 						{name : 'date', type:'date'},
 						{name : 'refname',type:'string'},
 						{name : 'regno',type:'string'},
                      	{name : 'vehname', type: 'string'  },
                      	{name : 'yom',type:'yom'},
                      	{name : 'matreqdocno',type:'number'},
                      	{name : 'techapproval',type:'number'},
                      	{name : 'finapproval',type:'number'},
                      	{name : 'reqstatus',type:'string'},
                      	{name : 'jobdocno',type:'number'},
                      	{name : 'jobvocno',type:'number'},
                      	{name : 'billto',type:'string'},
                      	{name : 'serviceadvisor',type:'string'},
                      	{name : 'brhid',type:'string'}
                      	
             ],
             localdata: gipdata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        $("#GIPGrid").on("bindingcomplete", function (event) {
        	var mode='<%=mode%>';
        	if(mode=="2"){
        		$('#GIPGrid').jqxGrid('setcolumnproperty', 'jobvocno', 'hidden',false);
        		$('#GIPGrid').jqxGrid('setcolumnproperty', 'vehname', 'width','18%');
        	}
        	else{
        		$('#GIPGrid').jqxGrid('setcolumnproperty', 'jobvocno', 'hidden',true);
        		$('#GIPGrid').jqxGrid('setcolumnproperty', 'vehname', 'width','22%');
        	}
        	$('.page-loader').hide();
        });                       
        	 
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#GIPGrid").jqxGrid(
                {
                	width: '100%',
                    height: 250,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'GIP Doc No',datafield: 'gatedocno', width: '10%',hidden:true},
    					{ text: 'Mat.Req.Doc No',datafield: 'matreqdocno', width: '10%',hidden:true},
    					{ text: 'Tech.Approval',datafield: 'techapproval', width: '10%',hidden:true},
    					{ text: 'Fin.Approval',datafield: 'finapproval', width: '10%',hidden:true},
    					{ text: 'GIP No',datafield: 'gatevocno', width: '5%'},
    					{ text: 'Date',datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Status',datafield:'reqstatus',width:'7%'},
    					{ text: 'Client',datafield: 'refname', width: '15%'},
    					{ text: 'Bill To',datafield: 'billto', width: '15%'},
    					{ text: 'Service Advisor',datafield: 'serviceadvisor', width: '15%'},
    					{ text: 'Reg No',datafield: 'regno', width: '7%'},
    					{ text: 'Vehicle',datafield: 'vehname', width: '18%'},
    					{ text: 'YoM',datafield: 'yom', width: '4%'},
    					{ text: 'Job Doc No',datafield:'jobdocno',width:'7%',hidden:true},
    					{ text: 'Job Card #',datafield:'jobvocno',width:'4%',hidden:true},
    					{ text: 'brhid',datafield:'brhid',width:'4%',hidden:true},
    					
    	              ]
                });
			
        $('#GIPGrid').on('rowdoubleclick', function (event) 
        		{ 
        		    var args = event.args;
        		    // row's bound index.
        		    var boundIndex = args.rowindex;
        		    // row's visible index.
        		    var visibleIndex = args.visibleindex;
        		    // right click.
        		    var rightclick = args.rightclick; 
        		    // original event.
        		    var ev = args.originalEvent;
        			$('#gipindex').val(boundIndex);	    
        		    $('#gatedocno').val($('#GIPGrid').jqxGrid('getcellvalue',boundIndex,'gatedocno'));
        		    $('#gatevocno').val($('#GIPGrid').jqxGrid('getcellvalue',boundIndex,'gatevocno'));
        		    $('#brhid').val($('#GIPGrid').jqxGrid('getcellvalue',boundIndex,'brhid'));
        		    $('#materialGrid').jqxGrid('clear');
        		    var gatedocno=$('#gatedocno').val();
        		    $('#materialdiv').load('materialGrid.jsp?id=1&gatedocno='+gatedocno);
        		    $('#materialGrid').jqxGrid('addrow', null, {});
        		    $('.textpanel').removeClass('hidden');
        		    var text="GIP #"+$('#gatevocno').val();
        		    $('.textpanel p').text(text);
        		});
	});
</script>
<div id="GIPGrid"></div>
<input type="hidden" name="gipindex" id="gipindex">