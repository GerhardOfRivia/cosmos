"use strict";(self.webpackChunkdocs_openc3_com=self.webpackChunkdocs_openc3_com||[]).push([["7072"],{5066:function(e,t,o){o.r(t),o.d(t,{metadata:()=>n,contentTitle:()=>c,default:()=>l,assets:()=>r,toc:()=>d,frontMatter:()=>i});var n=JSON.parse('{"id":"tools/command_history","title":"Command History (Enterprise)","description":"See all the commands sent, by whom, and if successful","source":"@site/docs/tools/command_history.md","sourceDirName":"tools","slug":"/tools/command_history","permalink":"/docs/tools/command_history","draft":false,"unlisted":false,"editUrl":"https://github.com/OpenC3/cosmos/tree/main/docs.openc3.com/docs/tools/command_history.md","tags":[],"version":"current","frontMatter":{"title":"Command History (Enterprise)","description":"See all the commands sent, by whom, and if successful","sidebar_custom_props":{"myEmoji":"\uD83D\uDEE0\uFE0F"}},"sidebar":"defaultSidebar","previous":{"title":"Command and Telemetry Server","permalink":"/docs/tools/cmd-tlm-server"},"next":{"title":"Data Extractor","permalink":"/docs/tools/data-extractor"}}'),s=o("5893"),a=o("65");let i={title:"Command History (Enterprise)",description:"See all the commands sent, by whom, and if successful",sidebar_custom_props:{myEmoji:"\uD83D\uDEE0\uFE0F"}},c=void 0,r={},d=[{value:"Introduction",id:"introduction",level:2},{value:"Selecting Time",id:"selecting-time",level:3},{value:"Commands Table",id:"commands-table",level:2}];function m(e){let t={a:"a",h2:"h2",h3:"h3",img:"img",p:"p",...(0,a.a)(),...e.components};return(0,s.jsxs)(s.Fragment,{children:[(0,s.jsx)(t.h2,{id:"introduction",children:"Introduction"}),"\n",(0,s.jsx)(t.p,{children:"Command History provides the ability to see all the commands sent in COSMOS. Commands are listed in time execution order and include who sent the command and whether they were successful (if validated)."}),"\n",(0,s.jsx)(t.p,{children:(0,s.jsx)(t.img,{alt:"Command History",src:o(2776).Z+"",width:"2878",height:"1660"})}),"\n",(0,s.jsx)(t.h3,{id:"selecting-time",children:"Selecting Time"}),"\n",(0,s.jsx)(t.p,{children:"By default, Command History displays the last hour of commands and then continues streaming commands as they are sent. You can select a different time range using the start date / time and end date / time choosers."}),"\n",(0,s.jsx)(t.h2,{id:"commands-table",children:"Commands Table"}),"\n",(0,s.jsx)(t.p,{children:"The commands table is sorted by Time and list the User (or process), the Command, the Result and an optional Description."}),"\n",(0,s.jsx)(t.p,{children:"As shown above, the User can be an actual user in the system (admin, operator) or a background process (DEFAULT__MULTI__INST, DEFAULT__DECOM__INST2)."}),"\n",(0,s.jsxs)(t.p,{children:["The Result field is the result of executing Command Validators established by the ",(0,s.jsx)(t.a,{href:"../configuration/command#validator",children:"VALIDATOR"})," keyword. Command Validators are either a Ruby or Python class which is used to validate the command success or failure with both a pre_check and post_check method. Usually when a command fails, a description is given as in the example above."]}),"\n",(0,s.jsxs)(t.p,{children:["For more information read the ",(0,s.jsx)(t.a,{href:"../configuration/command#validator",children:"VALIDATOR"})," documentation and also see the ",(0,s.jsx)(t.a,{href:"https://github.com/OpenC3/cosmos/blob/main/openc3-cosmos-init/plugins/packages/openc3-cosmos-demo/targets/INST/lib/inst_cmd_validator.rb",children:"Ruby Example"})," and the ",(0,s.jsx)(t.a,{href:"https://github.com/OpenC3/cosmos/blob/main/openc3-cosmos-init/plugins/packages/openc3-cosmos-demo/targets/INST2/lib/inst2_cmd_validator.py",children:"Python Example"})," in the ",(0,s.jsx)(t.a,{href:"https://github.com/OpenC3/cosmos/tree/main/openc3-cosmos-init/plugins/packages/openc3-cosmos-demo",children:"COSMOS Demo"}),"."]})]})}function l(e={}){let{wrapper:t}={...(0,a.a)(),...e.components};return t?(0,s.jsx)(t,{...e,children:(0,s.jsx)(m,{...e})}):m(e)}},2776:function(e,t,o){o.d(t,{Z:function(){return n}});let n=o.p+"assets/images/command_history-ecc9b618661ad0aefa0700047a8ab3b094372f2aa427e9fcd270dcd352a30408.png"},65:function(e,t,o){o.d(t,{Z:function(){return c},a:function(){return i}});var n=o(7294);let s={},a=n.createContext(s);function i(e){let t=n.useContext(a);return n.useMemo(function(){return"function"==typeof e?e(t):{...t,...e}},[t,e])}function c(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(s):e.components||s:i(e.components),n.createElement(a.Provider,{value:t},e.children)}}}]);