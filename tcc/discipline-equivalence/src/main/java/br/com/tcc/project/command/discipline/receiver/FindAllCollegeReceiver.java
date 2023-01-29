package br.com.tcc.project.command.discipline.receiver;

import br.com.portoseguro.payments.common.command.impl.AbstractReceiver;
import br.com.portoseguro.payments.common.gateway.annotation.CommandReceiver;
import br.com.tcc.project.command.FindDisciplineByCode;
import br.com.tcc.project.command.discipline.mapper.RegisterDisciplineMapper;
import br.com.tcc.project.command.mongo.model.DisciplineDocument;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;

import java.util.List;

import static org.springframework.data.mongodb.core.query.Criteria.where;
import static org.springframework.data.mongodb.core.query.Query.query;

@CommandReceiver(FindDisciplineByCode.class)
public class FindDisciplineByCodeReceiver
    extends AbstractReceiver<FindDisciplineByCode.Request, DisciplineDocument> {

  @Autowired @Setter private MongoTemplate mongoTemplate;

  @Override
  protected DisciplineDocument doExecute(FindDisciplineByCode.Request parameter) {

    return mongoTemplate.findOne(query(where(DisciplineDocument.FieldName.ORIGIN_CODE).is(parameter.getDisciplineCode())), DisciplineDocument.class);
  }
}
