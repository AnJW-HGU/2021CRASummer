'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Comment extends Model {
        static associate(models) {
            // define association here
            this.hasMany(models.Recomment, {
                foreignKey: 'comment_id'
            });
            this.hasMany(models.Photo, {
                foreignKey: 'comment_id'
            });
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
            default: 0,
        },
        deleted_date: {
            type: DataTypes.DATE,
            allowNull: true,
        },
        adopted_status: {
            type: DataTypes.TINYINT(1),
            allowNull: false,
            default: 0
        },
        deleted_status: {
            type: DataTypes.TINYINT(1),
            allowNull: false,
            default: 0
        },
    }, {
        sequelize,
        modelName: 'Comment',
        tableName: 'Comments',
        createdAt: 'written_date',
        updatedAt: 'revised_date',
    });
    return Comment;
};
