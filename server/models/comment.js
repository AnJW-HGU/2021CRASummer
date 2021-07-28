'use strict';
const {Model} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Comment extends Model {
        static associate(models) {
            // define association here
            this.hasMany(models.Recomment);
            this.hasMany(models.Photo);
            this.belongsTo(models.Post, {
                foreignKey: 'post_id'
            });
            this.belongsTo(models.User, {
                foreignKey: 'user_id'
            });
    }
  };
  Comment.init({
    id: {
        primaryKey: true,
        autoIncrement: true,
        type: DataTypes.INTEGER,
        allowNull: false
    },
    post_id: {
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
    recommends_count: {
        type: DataTypes.INTEGER,
        defaultValue: 0,
        allowNull: false,
    },
    reports_count: {
        type: DataTypes.INTEGER,
        defaultValue: 0,
        allowNull: false,
    },
    written_date: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    revised_date: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    deleted_date: {
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
    modelName: 'Comment',
    tableName: 'Comments'
  });
  return Comment;
};

