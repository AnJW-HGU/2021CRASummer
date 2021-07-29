'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Post extends Model {
        static associate(models) {
	    this.hasMany(models.Comment);
            this.hasMany(models.Photo);
            //this.hasOne(models.Inpuiry);              // check reported post in inpuiry
            this.belongsTo(models.Classification, {
                foreignKey: 'classification_id',
            });
            this.belongsTo(models.User, {
                foreignKey: 'user_id',
            });
	}
    };
    Post.init({
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.INTEGER,
            allowNull: false
        },
        title: {
            type: DataTypes.STRING(100),
            allowNull: false,
        },
        content: {
            type: DataTypes.TEXT,
            allowNull: false,
        },
        comments_count: {
            type: DataTypes.INTEGER,
            allowNull: false,
            defaultValue: 0,
        },
        reports_count: {
            type: DataTypes.INTEGER,
            allowNull: false,
            defaultValue: 0,
        },
        deleted_date: {
            type: DataTypes.DATE,
            allowNull: true,
        },
        adopted_status: {
            type: DataTypes.TINYINT,
            allowNull: false,
            defalutValue: 0
        },
        deleted_status: {
            type: DataTypes.TINYINT,
            allowNull: true,
            defalutValue: 0
        },
    },{
        sequelize,
        modelName: 'Post',
        tableName: 'Posts',
        createdAt: 'written_date',
        updatedAt: 'revised_date',
    } );
    return Post;
};
