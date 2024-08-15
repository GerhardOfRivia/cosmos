"use strict";(self.webpackChunkdocs_openc3_com=self.webpackChunkdocs_openc3_com||[]).push([[5772],{9824:(e,t,i)=>{i.r(t),i.d(t,{assets:()=>l,contentTitle:()=>a,default:()=>f,frontMatter:()=>o,metadata:()=>d,toc:()=>r});var n=i(4848),s=i(8453);const o={title:"Little Endian Bitfields"},a=void 0,d={id:"guides/little-endian-bitfields",title:"Little Endian Bitfields",description:"Defining little endian bitfields is a little weird but is possible in COSMOS. However, note that APPEND does not work with little endian bitfields.",source:"@site/docs/guides/little-endian-bitfields.md",sourceDirName:"guides",slug:"/guides/little-endian-bitfields",permalink:"/docs/guides/little-endian-bitfields",draft:!1,unlisted:!1,editUrl:"https://github.com/OpenC3/cosmos/tree/main/docs.openc3.com/docs/guides/little-endian-bitfields.md",tags:[],version:"current",frontMatter:{title:"Little Endian Bitfields"},sidebar:"defaultSidebar",previous:{title:"Custom Widgets",permalink:"/docs/guides/custom-widgets"},next:{title:"Local Mode",permalink:"/docs/guides/local-mode"}},l={},r=[];function c(e){const t={code:"code",li:"li",ol:"ol",p:"p",pre:"pre",...(0,s.R)(),...e.components};return(0,n.jsxs)(n.Fragment,{children:[(0,n.jsx)(t.p,{children:"Defining little endian bitfields is a little weird but is possible in COSMOS. However, note that APPEND does not work with little endian bitfields."}),"\n",(0,n.jsx)(t.p,{children:"Here are the rules on how COSMOS handles LITTLE_ENDIAN data:"}),"\n",(0,n.jsxs)(t.ol,{children:["\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsx)(t.p,{children:"COSMOS bit offsets are always defined in BIG_ENDIAN terms. Bit 0 is always the most significant bit of the first byte in a packet, and increasing from there."}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsx)(t.p,{children:"All 8, 16, 32, and 64-bit byte-aligned LITTLE_ENDIAN data types define their bit_offset as the most significant bit of the first byte in the packet that contains part of the item. (This is exactly the same as BIG_ENDIAN). Note that for all except 8-bit LITTLE_ENDIAN items, this is the LEAST significant byte of the item."}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsx)(t.p,{children:"LITTLE_ENDIAN bit fields are defined as any LITTLE_ENDIAN INT or UINT item that is not 8, 16, 32, or 64-bit and byte aligned."}),"\n"]}),"\n",(0,n.jsxs)(t.li,{children:["\n",(0,n.jsx)(t.p,{children:"LITTLE_ENDIAN bit fields must define their bit_offset as the location of the most significant bit of the bitfield in BIG_ENDIAN space as described in rule 1 above. So for example. The following C struct at the beginning of a packet would be defined like so:"}),"\n"]}),"\n"]}),"\n",(0,n.jsx)(t.pre,{children:(0,n.jsx)(t.code,{className:"language-c",children:'struct {\n  unsigned short a:4;\n  unsigned short b:8;\n  unsigned short c:4;\n}\n\nITEM A 4 4 UINT "struct item a"\nITEM B 12 8 UINT "struct item b"\nITEM C 8 4 UINT "struct item c"\n'})}),"\n",(0,n.jsx)(t.p,{children:"This is hard to visualize, but the structure above gets spread out in a byte array like the following after byte swapping: least significant 4 bits of b, 4-bits a, 4-bits c, most significant 4 bits of b."}),"\n",(0,n.jsx)(t.p,{children:"The best advice is to experiment and use the View Raw feature in the Command and Telemetry Service to inspect the bytes of the packet and adjust as necessary."})]})}function f(e={}){const{wrapper:t}={...(0,s.R)(),...e.components};return t?(0,n.jsx)(t,{...e,children:(0,n.jsx)(c,{...e})}):c(e)}},8453:(e,t,i)=>{i.d(t,{R:()=>a,x:()=>d});var n=i(6540);const s={},o=n.createContext(s);function a(e){const t=n.useContext(o);return n.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function d(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(s):e.components||s:a(e.components),n.createElement(o.Provider,{value:t},e.children)}}}]);