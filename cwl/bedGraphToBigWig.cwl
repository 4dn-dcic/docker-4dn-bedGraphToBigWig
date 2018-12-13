#!/usr/bin/env cwl-runner 

class: CommandLineTool

cwlVersion: v1.0

requirements:
- class: DockerRequirement
  dockerPull: "4dndcic/4dn-bedgraphtobigwig:v4"

- class: "InlineJavascriptRequirement"

inputs:
 chromsize:
  type: File
  inputBinding:
   position: 2

 bgfile:
  type: File
  inputBinding:
   position: 1
 
 outdir:
  type: string
  inputBinding:
   position: 3 
  default: "."

outputs:
 bwfile:
  type: File
  outputBinding:
   glob: "$(inputs.outdir + '/' + '*.bw')"
  
baseCommand: ["run-bedtobigwig.sh"]
