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
        type: DataTypes.INTEGER,
        allowNull: false
    },
    comment_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    content: {
        type: DataTypes.TEXT,
        allowNull: false,
    },
    reports_count: {
        type: DataTypes.INTEGER,
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
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    deleted_status: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
  }, {
    sequelize,
    modelName: 'Recomment',
    tableName: 'Recomments'
  });
  return Recomment;
};

