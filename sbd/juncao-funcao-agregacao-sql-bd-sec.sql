SELECT idpessoa, idtarefa, nomepessoa from pessoa
natural join tarefa;

SELECT nomepessoa, descricaotarefa from pessoa
natural join tarefa;

SELECT nomepessoa, descricaotarefa from pessoa p
inner join tarefa t on p.idpessoa = t.idpessoa;

select p.nomepessoa from pessoa p
inner join inscricao i on i.idpessoa = p.idpessoa group by i.idpessoa, p.nomepessoa having count(i.idpessoa) > 1;

select p.nomepessoa from pessoa p
inner join inscricao i on i.idpessoa = p.idpessoa group by i.idpessoa, p.nomepessoa having count(i.idpessoa) >= 1;

select nomepessoa from pessoa p
inner join servico s on s.idresponsavel = p.idpessoa group by s.idresponsavel, p.idpessoa, s.idservico having count(s.idresponsavel) >= 1;

select nomepessoa from pessoa p 
where 
	p.nomepessoa in (
		select p.nomepessoa 
		from pessoa p 
		inner join 
			inscricao i on i.idpessoa = p.idpessoa 
		group by i.idpessoa, p.nomepessoa 
		having count(i.idpessoa) >= 1
	)
	and 
	p.nomepessoa in (
		select nomepessoa 
		from pessoa p 
		inner join 
			servico s on s.idresponsavel = p.idpessoa 
		group by s.idresponsavel, p.idpessoa, s.idservico 
		having count(s.idresponsavel) >= 1
	)
;

select p.nomepessoa, e.nomeempresa from pessoa p
full outer join empresa e 
on e.idempresa = p.idempresa


((select 
	s.descricaoservico, e.nomeempresa as nome, 'Empresa' as tipo 
from servico s
inner join 
	prestadora p on s.idresponsavel = p.idresponsavel
full outer join 
	empresa e on e.idempresa = p.idempresa)
union (
		select 
			s.descricaoservico, 
			p.nomepessoa as nome, 
			'Pessoa' as tipo 
		from servico s
		full outer join 
			pessoa p on s.idresponsavel = p.idresponsavel
	   )
);

select i.idtarefa, t.descricaotarefa, count(i.idtarefa) as "numero_inscritos"
from tarefa t
inner join 
	inscricao i on t.idtarefa = i.idtarefa
group by i.idtarefa, t.descricaotarefa
having count(i.idtarefa) >= 2



select p.cpf, p.nomepessoa, count(i.idtarefa) as "numero_tarefas"
from inscricao i
natural join pessoa p
group by p.cpf, p.nomepessoa
having count(i.idtarefa) > 1

select p.cpf, p.nomepessoa, count(i.idtarefa) as "numero_tarefas"
from inscricao i
natural join pessoa p
group by p.cpf, p.nomepessoa
having count(i.idtarefa) > 1
and p.cpf in (select cpf from pessoa where idresponsavel is null)

select s.idservico, s.descricaoservico, s.custoservico, s.dataterminoservico, p.nomepessoa, p.datapagamentoinscricao from servico s
inner join inscricao i on s.idresponsavel = i.idpessoa
inner join pessoa p on p.idpessoa = i.idpessoa
where s.dataterminoservico < p.datapagamentoinscricao

select * from servico s
full outer join inscricao i on i.idpessoa = s.idresponsavel

select * from pessoa

select * from promotora

select e.idempresa from empresa e
	inner join organizadora o on e.idempresa = o.idempresa
	union
	select e.idempresa from empresa e 
	inner join patrocinadora p on e.idempresa = p.idempresa

insert into promotora
(
	select e.idempresa from empresa e
	inner join organizadora o on e.idempresa = o.idempresa
	union
	select e.idempresa from empresa e 
	inner join patrocinadora p on e.idempresa = p.idempresa
)

delete from prestadora where idempresa not in (
	select e.idempresa from empresa e 
	inner join prestadora p on e.idempresa = p.idempresa
	inner join servico s on s.idresponsavel = p.idresponsavel
	union
	select e.idempresa from empresa e 
	inner join organizadora o on e.idempresa = o.idempresa
	union
	select e.idempresa from empresa e 
	inner join promotora p on e.idempresa = p.idempresa
	union
	select e.idempresa from empresa e 
	inner join patrocinadora p on e.idempresa = p.idempresa
)

select * from prestadora

(select e.idempresa from empresa e 
	inner join prestadora p on e.idempresa = p.idempresa
	inner join servico s on s.idresponsavel = p.idresponsavel
union
select e.idempresa from empresa e 
	inner join organizadora o on e.idempresa = o.idempresa
union
select e.idempresa from empresa e 
	inner join promotora p on e.idempresa = p.idempresa
union
select e.idempresa from empresa e 
	inner join patrocinadora p on e.idempresa = p.idempresa
)

select s.idservico, s.descricaoservico, s.custoservico from servico s
inner join responsavel r on s.idresponsavel = r.idresponsavel
inner join pessoa p on p.idresponsavel = r.idresponsavel
inner join empresa e on p.idempresa = e.idempresa
inner join patrocinadora p2 on p2.idempresa = e.idempresa

update servico set custoservico = (custoservico-(custoservico*0.30)) where idservico in (
	select s.idservico from servico s
	inner join responsavel r on s.idresponsavel = r.idresponsavel
	inner join pessoa p on p.idresponsavel = r.idresponsavel
	inner join empresa e on p.idempresa = e.idempresa
	inner join patrocinadora p2 on p2.idempresa = e.idempresa
)

select * from servico s
inner join responsavel r on s.idresponsavel = r.idresponsavel

select * from patrocinadora

