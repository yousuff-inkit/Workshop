<%@ page import="com.workshop.gateinpassalice.ClsGateInPassAliceDAO" %>
<% ClsGateInPassAliceDAO cdl=new ClsGateInPassAliceDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
 String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
%>
<script type="text/javascript">
       var id='<%=id%>'; 
       var data1=[];
       if(id=="1"){
       	data1='<%=cdl.ReisterDetailsSearch(cldocno,id,regno)%>'; 
      }
      else{
      	data1=[];
      	}
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'regno', type: 'number'   },
							{name : 'chasis', type: 'String'   },
							{name : 'pltid', type: 'String'   },
							{name : 'brdid', type: 'String'   },
							{name : 'modid', type: 'String'   },
							{name : 'yom', type: 'String'   },
							{name : 'remarks', type: 'String'   },
							{name : 'kmin', type: 'String'   },
							{name : 'fuel', type: 'String'   },
							{name : 'repairtype', type: 'String'   },
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxRegisterSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Reg No',  datafield: 'regno', width: '100%' },
							{ text: 'Chassis No',  datafield: 'chasis', width: '100%',hidden:true },
							{ text: 'platecode',  datafield: 'pltid', width: '100%',hidden:true  },
							{ text: 'Brdid',  datafield: 'brdid', width: '100%',hidden:true  },
							{ text: 'Modid',  datafield: 'modid', width: '100%',hidden:true  },
							{ text: 'Yom',  datafield: 'yom', width: '100%',hidden:true  },
							{ text: 'Remarks',  datafield: 'remarks', width: '100%',hidden:true  },
							{ text: 'KM',  datafield: 'kmin', width: '100%',hidden:true  },
							{ text: 'Fuel',  datafield: 'fuel', width: '100%',hidden:true  },
							{ text: 'Repairtype',  datafield: 'repairtype', width: '100%',hidden:true  },
						]
            });
            
              $('#jqxRegisterSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                
              
                document.getElementById("vehregno").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "regno");
                document.getElementById("vehuserothers").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "chasis");
                document.getElementById("vehplatecode").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "pltid");
                document.getElementById("cmbbrand").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "brdid");
                document.getElementById("cmbmodel").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "modid");
                document.getElementById("hidcmbmodel").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "modid");
                document.getElementById("cmbyom").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "yom");
                //document.getElementById("vehothers").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
                //document.getElementById("vehkm").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "kmin");
                //document.getElementById("cmbfueltype").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "fuel");
                //document.getElementById("cmbrepairtype").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "repairtype");
                document.getElementById("latestkm").value = $('#jqxRegisterSearch').jqxGrid('getcellvalue', rowindex1, "kmin");
                getModel(document.getElementById("cmbbrand").value);
                $('#reisterwindow').jqxWindow('close'); 
            });   
        });
    </script>
    <div id="jqxRegisterSearch"></div>