'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Recomment extends Model {
    static associate(models) {
      // define association here
      this.belongsTo(models.Comment, {
                foreignKey: 'comment_id'
      });
      this.belongsTo(models.User, {
                foreignKey: 'user_id'
      });
    }
  };
  Recomment.init({
    id: {
        primaryKey: true,
        autoIncrement: true,
        type: DataTypes.SMALLINT,
        allowNull: false
    },
    comment_id: {
        type: DataTypes.SMALLINT,
        allowNull: false,
    },
    user_id: {
        type: DataTypes.SMALLINT,
        allowNull: false,
    },
    content: {
        type: DataTypes.TEXT,
        allowNull: false,
    },
    reports_count: {
        type: DataTypes.SMALLINT,
        defaultValue: 0,
        allowNull: false,
    },
    written_date:  {
        type: DataTypes.DATE,
        allowNull: false,
    },
    revised_date:  {
        type: DataTypes.DATE,
        allowNull: false,
    },
    deleted_date:  {
        type: DataTypes.DATE,
        allowNull: false,
    },
    adopted_status: {
        type: DataTypes.TINYINT(1),
        allowNull: false,
    },
    deleted_status: {
        type: DataTypes.TINYINT(1),
        allowNull: false,
    },
  }, {
    sequelize,
    modelName: 'Recomment',
    tableName: 'Recomments'
  });
  return Recomment;
};

