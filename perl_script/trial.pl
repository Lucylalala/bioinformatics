#!/usr/bin/perl -w
 
#加载Bio::Seq模块。
use Bio::Seq;  
 
#调用Bio::Seq模块的new方法，可以建立一个序列对象，命名为$seq_obj。
$seq_obj = Bio::Seq->new; 
 
#给这个新建的$seq_obj对象赋予三个属性的值：dispaly_name（序列的名称），desc（序列的描述）以及seq（序列的内容） 
$seq_obj->display_name("gi|147605|gb|J01673.1|ECORHO");
$seq_obj->desc("E.coli rho gene coding for transcription termination factor");
$seq_obj->seq("AACCCTAGCACTGCGCCGAAATATGGCATCCGTGGTATCCCGACTCTGCTGCTGTTCAAAAACGGTGAAG");
 
#创建了三个普通的标量变量来存放三个属性值
my ($fasta_name,$fasta_desc,$fasta_seq); 
 
#调用对象的display_name方法来得到名称
$fasta_name = $seq_obj->display_name; 
#调用对象的desc方法来得到描述
$fasta_desc = $seq_obj->desc; 
#调用对象的seq方法来得到序列        
$fasta_seq = $seq_obj->seq;     
 
#现在可以打印三个属性值了 
print "NAME:\t$fasta_name\nDESCRIBE:\t$fasta_desc\nSEQUENCE:\t$fasta_seq\n";
