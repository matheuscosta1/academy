package br.com.tcc.project.command.discipline.receiver;

import br.com.portoseguro.payments.common.command.impl.AbstractReceiver;
import br.com.portoseguro.payments.common.gateway.annotation.CommandReceiver;
import br.com.tcc.project.command.DisciplineEquivalenceProcessor;
import br.com.tcc.project.command.discipline.mapper.RegisterDisciplineMapper;
import br.com.tcc.project.command.mongo.model.DisciplineDocument;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import static org.springframework.data.mongodb.core.query.Criteria.where;
import static org.springframework.data.mongodb.core.query.Query.query;

@CommandReceiver(DisciplineEquivalenceProcessor.class)
public class FindDisciplineByCode
    extends AbstractReceiver<DisciplineEquivalenceProcessor.Request, Void> {

  @Autowired @Setter private RegisterDisciplineMapper registerDisciplineMapper;

  @Autowired @Setter private MongoTemplate mongoTemplate;

  @Override
  protected Void doExecute(DisciplineEquivalenceProcessor.Request parameter) {

    mongoTemplate.find(query(where(DisciplineDocument.FieldName.ORIGIN_CODE).is(parameter));
    CreditCardSensitiveDataDocument creditCardSensitiveDataDocument =
            mongoTemplate.findOne(
                    ),
                    CreditCardSensitiveDataDocument.class);
    return null;
  }
}
